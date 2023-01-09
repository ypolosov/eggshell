#!/usr/bin/env bash

pushd frontend
sh .devcontainer/scripts/post-create.sh
popd

pushd backend
sh .devcontainer/scripts/post-create.sh
popd