#!/bin/sh

read -p "Enter AWS access key ID: "  access_key
read -s -p "Enter AWS secret access key: " secret_key
echo ""

read -p "Enter the region to deploy in: " region_name
read -p "Enter the account ID: " account_id

sh zip.sh &>/dev/null

ansible-playbook deploy-run-crossfit.yml \
  -e "target_region=$region_name"\
  -e "access_key=$access_key"\
  -e "account_id=$account_id"\
  -e "secret_key=$secret_key" -v

rm -rf lambda.zip
