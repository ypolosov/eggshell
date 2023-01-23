#!/usr/bin/env bash

echo "Deploying Application"

terraform login

pwd
ls -la
cd ./infra/claster/aws

terraform apply -auto-approve