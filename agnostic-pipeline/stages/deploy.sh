#!/usr/bin/env bash

echo "Deploying Application"

pwd
ls -la
cd ./infra/cluster/aws
echo TFE_TOKEN=$TFE_TOKEN
export TF_LOG=debug
terraform init

terraform apply -auto-approve