#!/usr/bin/env bash

echo "Deploying Application"

pwd
ls -la
cd ./infra/cluster/aws
echo TFE_TOKEN=$TFE_TOKEN
export TF_LOG=debug
# Create .terraformrc with credential config for user
cat >~/.terraformrc <<EOL
credentials "app.terraform.io" {
  token = "${TFE_TOKEN}"
}
EOL
cat ~/.terraformrc

# terraform init

terraform apply -auto-approve