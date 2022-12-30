#!/usr/bin/env bash
set -e

echo
echo "Archiving Application"

set -x

CONFIG_PATH="$PROJECT_DIR/.env"
cat "${CONFIG_PATH}"
source "${CONFIG_PATH}"

IMAGE="${ARCHIVE_REGISTRY}/${ARCHIVE_ACCOUNT}/${ARCHIVE_APP_NAME}:${ARCHIVE_TAG_NAME}"

if [[ ! -z "${DOCKER_PASSWORD}" ]]
then
    # cloud running
    echo "${DOCKER_PASSWORD?:}" | docker login -u "${ARCHIVE_ACCOUNT?:}" --password-stdin "${ARCHIVE_REGISTRY}"
else
    # local running
    docker login "${ARCHIVE_REGISTRY}"
fi
docker build -t "${IMAGE}" -f "${ARCHIVE_APP_NAME}/Dockerfile.prod" "./${ARCHIVE_APP_NAME}"
docker push "${IMAGE}"

