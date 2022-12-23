#!/usr/bin/env bash

pushd frontend
npm ci
popd

pushd backend
npm ci
popd