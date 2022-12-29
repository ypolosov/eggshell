#!/usr/bin/env bash
set -e

echo
echo "Ci Application"

set -x

echo "Build and push devcontainer..."
devcontainer build --workspace-folder . --push true --image-name docker.io/ypolosov/eggshell:1.1.1

npm ci

