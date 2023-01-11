#!/usr/bin/env bash
docker ps
devcontainer exec --container-id $(docker ps -aqf "name=eggshell-container") --id-label ci-container=XXXXX --workspace-folder . $@