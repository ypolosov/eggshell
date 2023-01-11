#!/usr/bin/env bash
docker ps
devcontainer exec --id-label ci-container=XXXXX --workspace-folder . $@