#!/usr/bin/env bash

echo "Deploying Application"

pwd
ls -la
cd ./infra/cluster/aws

terraform init

terraform apply -auto-approve