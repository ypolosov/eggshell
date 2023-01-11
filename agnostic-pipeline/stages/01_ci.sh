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

docker-compose -v
devcontainer --version

devcontainer up --id-label ci-container=XXXXX --workspace-folder .
