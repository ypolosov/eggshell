#!/usr/bin/env sh

pushd frontend
sh .devcontainer/scripts/post-create.sh
popd

pushd backend
sh .devcontainer/scripts/post-create.sh
popd