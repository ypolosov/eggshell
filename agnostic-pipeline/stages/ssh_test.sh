#!/usr/bin/env bash
set -e

echo
echo "Ssh testing"

set -x

CONFIG_PATH="$PROJECT_DIR/.env"
cat "${CONFIG_PATH}"
source "${CONFIG_PATH}"

# IMPORTANT !!! https://circleci.com/docs/github-integration/#establish-the-authenticity-of-an-ssh-host
echo
ssh-keyscan -p ${DEPLOY_PORT} ${DEPLOY_HOST} >> ~/.ssh/known_hosts
ssh ${DEPLOY_USER}@${DEPLOY_HOST} -p ${DEPLOY_PORT} hostname -f
