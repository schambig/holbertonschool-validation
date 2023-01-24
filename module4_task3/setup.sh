#!/bin/bash

# Install appropriate version of hugo to be run in docker container 'ubuntu 18.04'
# apt-get update && apt-get install -y make wget
# wget https://github.com/gohugoio/hugo/releases/download/v0.109.0/hugo_extended_0.109.0_Linux-64bit.tar.gz
# tar -xvf hugo_extended_0.109.0_Linux-64bit.tar.gz hugo
# mv hugo /usr/local/bin/
# rm -f hugo_extended_0.109.0_Linux-64bit.tar.gz || true

# Install markdownlint and zip tools

npm install -g markdownlint-cli -y

# Generate a Go-Hugo website
# make build

# Uninstall go
sudo apt-get remove golang-go
rm -rf /usr/local/go || true

# Clean environment files and directory
rm -rf dist/ 2> /dev/null
rm -f awesome-api || true
rm -f coverage-units.out || true
rm -f coverage-integrations.out || true
