#!/usr/bin/env bash
set -x

CONFIG_PATH="$PROJECT_DIR/.env"
cat "${CONFIG_PATH}"
source "${CONFIG_PATH}"

echo
devcontainer exec --remote-env "TFE_TOKEN=$TFE_TOKEN" --container-id $(docker ps -aqf "name=eggshell-container") --id-label ci-container=XXXXX --workspace-folder . $@