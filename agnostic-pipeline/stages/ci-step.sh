#!/usr/bin/env bash
set -e

echo
echo "Ci Application"

# set -x

# CONFIG_PATH="$PROJECT_DIR/.env"
# cat "${CONFIG_PATH}"
# source "${CONFIG_PATH}"

# echo
echo "Install devcontainers/cli..."
npm install -g @devcontainers/cli

devcontainer up  --remote-env "TFE_TOKEN=$TFE_TOKEN" --remove-existing-container false --build-no-cache false --cache-from docker.io/ypolosov/eggshell --id-label ci-container=XXXXX --workspace-folder .
