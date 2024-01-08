#!/bin/bash

USER_ID=$(id -u)
COMPONENT=mongo
LOGFILE="/tmp/${COMPONENT}.log"
MONGO_REPO="curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"

stat() {
if [ $1 -eq 0 ] ; then
  echo -e "\e[31m success \e[0m"
else
  echo -e "\e[32m failure  \e[0m"
fi
}


if [ $USER_ID -ne 0 ]; then 
    echo -e "\e[31m this script is expected to be executed with sudo or root user\e[0m"
    echo -e "\e[35m Example usage: \n\t\t  \e[0m sudo bash scriptName componentName"
    exit 1
fi


echo -e "******\e[35m  configuring of ${COMPONENT}  \e[0m ******"


echo -e "configuring $COMPONENT REPO :"
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
stat $?


echo -e "Installing $COMPONENT REPO :"
yum install -y mongodb-org  &>> ${LOGFILE}
stat $?



