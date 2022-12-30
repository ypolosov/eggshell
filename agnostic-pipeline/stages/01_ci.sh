#!/usr/bin/env bash
set -e

echo
echo "Ci Application"

set -x

echo "Install devcontainers/cli..."
npm install -g @devcontainers/cli

echo "Build and push devcontainer..."
devcontainer build --workspace-folder . --image-name docker.io/ypolosov/eggshell:1.1.1
docker push docker.io/ypolosov/eggshell:1.1.1

npm ci

