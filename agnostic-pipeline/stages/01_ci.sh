#!/usr/bin/env bash
set -e

echo
echo "Ci Application"

set -x

echo "Install devcontainers/cli..."
npm install -g @devcontainers/cli

echo "Build and push devcontainer..."
export DOCKER_DEFAULT_PLATFORM=linux/amd64
devcontainer build --workspace-folder . --push true --image-name docker.io/ypolosov/eggshell:1.1.1

npm ci

