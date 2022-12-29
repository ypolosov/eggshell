#!/usr/bin/env sh
set -e

PROJECT_DIR=app-2

docker build -t local-agnostic-pipeline -f ./agnostic-pipeline/Dockerfile.prod ./agnostic-pipeline \
&& docker run \
    --env PROJECT_DIR="${PROJECT_DIR}" \
    --env REPOSITORY_URL=https://github.com/ypolosov/generic-pipelines-using-docker.git \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ~/.docker:/root/.docker \
    -v ~/.ssh:/root/.ssh \
    local-agnostic-pipeline \
    /stages/00_run.sh

