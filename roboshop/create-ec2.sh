#!/bin/bash

# This script is going to create EC2 Servers

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g') #never hardcode the ami
SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=b56-allow-all"| jq ".SecurityGroups[].GroupId" | sed -e 's/"//g') #never hardcode the ami
INSTANCE_TYPE="t3.micro"
COMPONENT=$1
HOSTEDZONEID="Z074951730BXMKX1S7VS1"


if [ -z $1 ] || [ -z $2 ] ; then 
    echo -e "\e[31m ****** COMPONENT NAME & ENV ARE NEEDED ****** \e[0m \n\t\t"
    echo -e "\e[36m \t\t Example Usage : \e[0m  bash create-ec2 ratings dev"
    exit 1 
fi 

echo -e "******* \e[32m $COMPONENT \e[0mServer Creation in Progress]  ******!!!!!"

#aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENT}}]"
#PRIVATE_IP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENT}}]" | jq ".Instances[].PrivateIpAddress" | sed -e 's/"//g')
PRIVATE_IP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENT}-${ENV}}]" | jq ".Instances[].PrivateIpAddress" | sed -e 's/"//g')
echo -e "******* \e[32m $COMPONENT-$ENV \e[0m Server Creation Is Compelted ******* !!!!!! \n\n"


echo -e "*******  \e[33m $COMPONENT \e[0m DNS Record Creation in Progress ******!!!!!"
sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${PRIVATE_IP}/" route53.json > /tmp/dns.json
#sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${PRIVATE_IP}/" route53.json > /tmp/dns.json
aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/dns.json
echo -e "******* \e[32m $COMPONENT-$ENV \e[0m DNS Record Creation In Completed ******* !!!!!!"








