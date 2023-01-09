#!/usr/bin/env bash

pushd frontend
sh .devcontainer/scripts/post-start.sh
popd

pushd backend
sh .devcontainer/scripts/post-start.sh
popd