#!/bin/bash

# This script is going to create EC2 Servers

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g') #never hardcode the ami
SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=b56-allow-all"| jq ".SecurityGroups[].GroupId" | sed -e 's/"//g') #never hardcode the ami
INSTANCE_TYPE="t3.micro"
COMPONENT=$1

echo -e "*******8 server Creation in Progress ******!!!!!"


aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENT}}]"

