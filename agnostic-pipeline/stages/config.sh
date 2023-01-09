#!/usr/bin/env bash
set -e

echo
echo "Reading Config"

set -x

CONFIG_PATH="$PROJECT_DIR/.env"
cat "${CONFIG_PATH}"
source "${CONFIG_PATH}"