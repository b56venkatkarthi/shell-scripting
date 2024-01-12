#!/bin/bash


USER_ID=$(id -u)
COMPONENT=catalogue
COMPONENT_URL="https://github.com/stans-robot-project/catalogue/archive/main.zip"
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"


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

#echo -n "Configuring NodeJs Repo ;"
#curl --silent --location https://rpm.nodesource.com/pub_16.x | sudo bash -
#stat $?

echo -n "Installing NodeJs  ;"
yum install nodejs -y   &>> $LOGFILE
stat $?


echo -n "Creating $APPUSER ;"
id $APPUSER   & >> $LOGFILE
if [ $? -ne 0 ] ; then
  useradd $APPUSER
  stat $?
else
   echo -e "\e[35m skiping \e[0m"
fi 

echo -n "Downloading $COMPOENNT ;"
curl -s -L -o /tmp/$COMPOENNT.zip &COMPONENT_URL
stat&?