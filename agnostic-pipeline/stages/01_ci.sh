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

devcontainer build --no-cache true --workspace-folder .
devcontainer up --id-label ci-container=XXXXX --workspace-folder .
docker ps
devcontainer exec --container-id $(docker ps -aqf "name=eggshell-container") --id-label ci-container=XXXXX --workspace-folder . echo "Build app"


