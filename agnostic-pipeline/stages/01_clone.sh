#!/usr/bin/env bash
set -e

echo
echo "Cloning Application"

# set -x

git clone "${REPOSITORY_URL:?}" .

