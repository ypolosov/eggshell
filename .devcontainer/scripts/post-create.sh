#!/usr/bin/env bash

LOCK_FILE="package-lock.json" 

pushd frontend
npm ci
if [ -f $LOCK_FILE ]; then
   npm ci
else
   npm i
fi
popd

pushd backend
npm ci
if [ -f $LOCK_FILE ]; then
   npm ci
else
   npm i
fi
popd