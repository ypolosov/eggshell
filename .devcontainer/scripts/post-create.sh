#!/usr/bin/env bash

pushd frontend
bash .devcontainer/scripts/post-create.sh
popd

pushd backend
bash .devcontainer/scripts/post-create.sh
popd