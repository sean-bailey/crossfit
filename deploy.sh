#!/bin/sh

read -p "Enter AWS access key ID: "  access_key
read -s -p "Enter AWS secret access key: " secret_key
echo ""

read -p "Enter the region to deploy in: " region_name


echo "Zipping up function..."
sh zip.sh &>/dev/null
echo "Running terraform"

cd terraform
terraform init
terraform apply -auto-approve -refresh=true -var 'access_key='$access_key -var 'secret_key='$secret_key -var 'region='$region_name

cd ..
rm -rf lambda.zip
