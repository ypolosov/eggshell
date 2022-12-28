#!/usr/bin/env bash

pushd frontend
bash .devcontainer/scripts/post-start.sh
popd

pushd backend
bash .devcontainer/scripts/post-start.sh
popd