#!/usr/bin/env bash

echo "Deploying Application"

pwd
ls -la
cd ./infra/cluster/aws
echo TFE_TOKEN=$TFE_TOKEN
terraform init

terraform apply -auto-approve