#!/usr/bin/env bash

LOCK_FILE="package-lock.json" 

if [ -f $LOCK_FILE ]; then
   npm ci
else
   npm i
fi