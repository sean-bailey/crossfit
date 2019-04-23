#!/bin/sh

read -p "Enter AWS access key ID: "  access_key
read -s -p "Enter AWS secret access key: " secret_key
echo ""

read -p "Enter the region app was deployed in: " region_name

pip install -U ansible


ansible-playbook cleanup-crossfit.yml \
  -e "target_region=$region_name"\
  -e "access_key=$access_key"\
  -e "secret_key=$secret_key" -v
