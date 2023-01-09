#!/usr/bin/env sh
set -e

echo
echo "Testing Application"

set -x

CONFIG_PATH="$PROJECT_DIR/.env"
cat "${CONFIG_PATH}"
source "${CONFIG_PATH}"

sh ./agnostic-pipeline/stages/run-in-devcontainer.sh \
node "$PROJECT_DIR/index.spec.js"