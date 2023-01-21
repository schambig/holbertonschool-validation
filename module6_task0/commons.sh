#!/bin/bash

set -eu -o pipefail

function exit_on_error() {
  echo "ERROR: $1"
  exit 1
}

function exit_on_grader_error() {
  echo "An error with the grader system occured, please report: $1"
  exit 1
}


function check_cmd () {
  for cli in "$@"
  do
    command -v "${cli}" >/dev/null 2>&1 \
      || exit_on_error "CHECKER ERROR: could not setup the correction environment, the command '${cli}' is missing. Please report the error."
  done
}

function start_docker() {
  check_cmd docker dockerd-entrypoint.sh sleep

  mkdir -p /etc/docker
  cat >/etc/docker/daemon.json <<EOF
{
  "dns-search": [],
  "exec-opts": [
    "native.cgroupdriver=cgroupfs"
  ]
}
EOF

  if docker ps >/dev/null 2>&1
  then
    echo STARTED
    return 0
  fi
  ulimit -u unlimited
  ulimit -s unlimited
  # ulimit -n unlimited
  dockerd-entrypoint.sh >/tmp/docker.log 2>&1 &

  until docker ps >/dev/null 2>&1
  do
    echo WAITING >/dev/null
    sleep 1
  done

  echo STARTED
  return 0
}

function execution_success() {
  check_cmd mktemp
  log_file="$(mktemp -p "$HOME")"
  if ! "$@" >"${log_file}" 2>&1
  then
    exit_on_error "Command $* failed with the following error:$(echo; cat "${log_file}")"
  fi
  return 0
}


function execution_failure() {
  check_cmd mktemp
  log_file="$(mktemp -p "$HOME")"
  if "$@" >"${log_file}" 2>&1
  then
    exit_on_error "Command $* succeeded while it should have failed, with the following log:$(echo; cat "${log_file}")"
  fi
  return 0
}

function setup_task_workdir() {
  {
    check_cmd cp cd
    # The repository cannot be in /tmp (because ramdisks or not namespaceable)
    repo_dir=/repo
    if [ "$(cd .. && pwd -P)" != "/repo" ]
    then
      if command -v rsync
      then
        # Faster if possible
        rsync -av -r ../ "${repo_dir}"
      else
        cp -av -r ../ "${repo_dir}"
      fi
    fi
    cd "${repo_dir}/${1}"
  } >grader.log 2>&1 || exit_on_grader_error "[setup_task_workdir] please report the following log: $(cat grader.log)."
}

function cleanup_docker() {
  check_cmd docker
  ## Always returns true!
  docker ps -q 2>/dev/null | xargs docker kill >/dev/null 2>&1 || true
  docker system prune --volumes --force >/dev/null 2>&1 || true
}

function get_running_aws_instances() {
  check_cmd aws yq
  aws ec2 describe-instances --filters='Name=instance-state-name,Values=running' | yq eval '.Reservations | length' -
}

function check_running_aws_instances() {
  check_cmd grep

  expected_nb_running_instances="${1}"
  grader_error="${2:-student_error}"
  current_nb_running_instances="$(get_running_aws_instances)"

  test "${expected_nb_running_instances}" -eq "${current_nb_running_instances}" \
    || {
      running_instance_names="$(aws ec2 describe-instances --filters='Name=instance-state-name,Values=running' | yq eval '.Reservations[].Instances[].Tags[] | select(.Key == "Name") | .Value' -)"
      error_msg="expected ${expected_nb_running_instances} running EC2 instances but found ${current_nb_running_instances} with the following names: ${running_instance_names}."
      if test "${grader_error}" == "grader_error"
      then
        exit_on_grader_error "${error_msg}"
      else
        exit_on_error "${error_msg}"
      fi
    }
}

# Returns a random string to insert "chaos" in corrections
function id_generator() {
  local size="${1:-6}" # Default is 6 chars
  env LC_CTYPE=C LC_ALL=C tr -dc "a-zA-Z0-9" < /dev/urandom | head -c "${size}"; echo
  return 0
}
