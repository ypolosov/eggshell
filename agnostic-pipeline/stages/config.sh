#!/usr/bin/env bash

echo "Check environment..."
docker info
docker version
docker compose version
docker-compose -v
node --version
npm --version
git --version
yarn --version
python --version
terraform -version
aws --version
aws sts get-caller-identity | cat
yc --version
yc config profile list | cat
