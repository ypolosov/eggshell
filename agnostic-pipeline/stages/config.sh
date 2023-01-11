#!/usr/bin/env bash
set -e

echo
echo "Reading Config"

set -x

CONFIG_PATH="$PROJECT_DIR/.env"
cat "${CONFIG_PATH}"
source "${CONFIG_PATH}"

echo "Check environment..."
docker info
docker version
docker compose version
docker-compose -v
node --version
npm --version
git --version
yarn --version
python --version