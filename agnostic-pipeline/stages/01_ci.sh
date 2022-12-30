#!/usr/bin/env bash
set -e

echo
echo "Ci Application"

set -x

CONFIG_PATH="$PROJECT_DIR/.env"
cat "${CONFIG_PATH}"
source "${CONFIG_PATH}"

echo "Install devcontainers/cli..."
npm install -g @devcontainers/cli

echo "Build and push devcontainer..."
devcontainer build --workspace-folder . --image-name docker.io/ypolosov/eggshell
docker push docker.io/ypolosov/eggshell

npm ci

