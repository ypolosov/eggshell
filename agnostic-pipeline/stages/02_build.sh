#!/usr/bin/env bash
set -e

echo
echo "Building Application"

set -x

CONFIG_PATH="$PROJECT_DIR/.env"
cat "${CONFIG_PATH}"
source "${CONFIG_PATH}"

npm install -g @devcontainers/cli

sh ./agnostic-pipeline/stages/run-in-devcontainer.sh \
echo "Build app"




