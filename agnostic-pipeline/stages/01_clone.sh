#!/usr/bin/env sh
set -e

echo
echo "Cloning Application"

set -x

git clone "${REPOSITORY_URL:?}" .

