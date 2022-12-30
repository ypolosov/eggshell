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

echo "Container registry login..."
if [[ ! -z "${DOCKER_PASSWORD}" ]]
then
    # cloud running
    echo "${DOCKER_PASSWORD?:}" | docker login -u "${ARCHIVE_ACCOUNT?:}" --password-stdin "${ARCHIVE_REGISTRY}"
else
    # local running
    docker login
fi

echo "Build and push devcontainer..."
devcontainer build --workspace-folder . --image-name docker.io/ypolosov/eggshell:1.1.1
docker push docker.io/ypolosov/eggshell:1.1.1

npm ci

