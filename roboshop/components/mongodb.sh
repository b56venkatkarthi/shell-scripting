#!/bin/bash

USER_ID=$(id -u)
COMPONENT=mongodb
LOGFILE="/tmp/${COMPONENT}.log"
MONGO_REPO="curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"
SCHEMA_URL="https://github.com/stans-robot-project/mongodb/archive/main.zip"
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


echo -n "configuring $COMPONENT REPO :"
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
stat $?


echo -n "Installing $COMPONENT REPO :"
yum install -y mongodb-org  &>> ${LOGFILE}
stat $?

echo -n "Enabling  $COMPONENT  :"
sed -i -e 's/127.0.0/0.0.0/' /etc/mongod.conf
stat $?


echo -n " Restarting ${COMPONENT} :"
systemctl enable mongod  &>> $LOGFILE
systemctl daemon-reload mongod &>>  $LOGFILE
systemctl restart mongod  &>> $LOGFILE
stat $?

echo -n " Downlaoding ${COMPONENT} :"
curl -s -L -o /tmp/mongodb.zip $SCHEMA_URL 
stat $?

echo -n " Extracting ${COMPONENT} :"
cd /tmp
unzip -o /tmp/${COMPONENT}.zip        & >>LOGFILE
stat $?

echo -n " Injecting Schema :"
cd /tmp/mongodb-main
mongodb < users.js
mongodb < catalogue.js
stat $?

echo -e "******\e[35m $COMPONENT configuration is completed \e[0m ******"





