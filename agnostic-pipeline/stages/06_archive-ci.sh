#!/usr/bin/env bash
set -e

echo
echo "Archive CI"

set -x

CONFIG_PATH="$PROJECT_DIR/.env"
cat "${CONFIG_PATH}"
source "${CONFIG_PATH}"

echo "Build and push devcontainer..."
devcontainer build --workspace-folder . --image-name docker.io/ypolosov/eggshell
docker push docker.io/ypolosov/eggshell
