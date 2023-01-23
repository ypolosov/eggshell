#!/usr/bin/env bash

echo "Deploying Application"

pwd
ls -la
cd ./infra/claster/aws

terraform apply -auto-approve