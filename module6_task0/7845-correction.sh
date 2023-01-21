#!/bin/bash

set -eu -o pipefail

#shellcheck disable=SC1090
source "$(dirname "$0")"/commons.sh

setup_task_workdir "./module4_task2"

test "$(start_docker)" == "STARTED" || exit_on_error "Checker issue: could not start the Docker Engine."

generated_files=("./awesome-api" "coverage-units.out" "coverage-integrations.out")

test ! -d ./dist/ || exit_on_error "Directory ./dist/ found, while it should not exist."
for file in "${generated_files[@]}"
do
  test ! -f "${file}" || exit_on_error "File ${file} found, while it should not exist initially."
done

## No image by default
execution_failure docker inspect awesome:build


###### Validate Lint
## Should build the image successfully (by transitive dependency)
execution_success make lint
execution_success docker inspect awesome:build >/dev/null 2>&1

## Dockerfile with a lint error: it should fail
echo 'FROM alpine' > build/Dockerfile
execution_failure make lint

## Cleanup
git checkout build/Dockerfile >/dev/null 2>&1 || exit_on_error "Could not reset file 'build/Dockerfile' with the git command line."
execution_success make build-docker

###### Validate Docker Test
## Success by default
execution_success make docker-tests
## Fails when no cst.yml
rm -f build/cst.yml
execution_failure make docker-tests
## Cleanup
git checkout build/cst.yml >/dev/null 2>&1 || exit_on_error "Could not reset file 'build/cst.yml' with the git command line."

## Fails when not implementing expected behavior (but lint passing)
echo 'FROM alpine:3.13' > build/Dockerfile
execution_failure make docker-tests

## Cleanup
git checkout build/Dockerfile >/dev/null 2>&1 || exit_on_error "Could not reset file 'build/Dockerfile' with the git command line."
execution_success make build-docker

## Validate other make goals
execution_success make build
test -d ./dist/ || exit_on_error "Directory ./dist/ not found."
test -f "${generated_files[0]}" || exit_on_error "File ${generated_files[0]} not found after running the command 'make build'."

execution_success make unit-tests
test -f "${generated_files[1]}" || exit_on_error "File ${generated_files[1]} not found after running the command 'make unit-tests'."

execution_success make integration-tests
test -f "${generated_files[2]}" || exit_on_error "File ${generated_files[2]} not found after running the command 'integration-tests'."

echo "OK"
