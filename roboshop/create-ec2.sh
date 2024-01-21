#!/bin/bash

# This script is going to create EC2 Servers

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g') #never hardcode the ami
SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=b56-allow-all"| jq ".SecurityGroups[].GroupId" | sed -e 's/"//g') #never hardcode the ami


echo -e "Creating server in Progress ******!!!!!"

