#!/bin/bash

USER_ID=$(id -u)
COMPONENT=frontend
LOGFILE=&>> "/tmp/${COMPONENT}.log"

if [ $USER_ID -ne 0 ]; then 
    echo -e "\e[31m this script is expected to be executed with sudo or root user\e[0m"
    echo -e "\e[35m Example usage: \n\t\t  \e[0m sudo bash scriptName componentName"
    exit 1

fi
    
echo -e "****** \e[34m configure frontend  service \e[0m ******"
echo -e  "Installing Nginx :"
yum install nginx -y      &>> LOGFILE



if [ $? -eq 0 ] ; then
  echo -e "\e[31m success \e[0m"
else
  echo -e "\e[32m failure  \e[0m"
fi

echo -n "Downloading $Component :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/$Component/archive/main.zip"

if [ $? -eq 0 ] ; then
  echo -e "\e[31m success \e[0m"
else
  echo -e "\e[32m failure  \e[0m"
fi

echo -n "cleanup of ${Component}  : "
cd /usr/share/nginx/html
rm -rf *   &>> $LOGFILE

if [ $? -eq 0 ] ; then
  echo -e "\e[31m success \e[0m"
else
  echo -e "\e[32m failure  \e[0m"
fi

echo -n "Extracting of ${Component} : "
unzip -o /tmp/frontend.zip   &>> $LOGFILE
if [ $? -eq 0 ] ; then
  echo -e "\e[31m success \e[0m"
else
  echo -e "\e[32m failure  \e[0m"
fi


echo -n "Configuring of ${Component} : "
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.con
if [ $? -eq 0 ] ; then
  echo -e "\e[31m success \e[0m"
else
  echo -e "\e[32m failure  \e[0m"
fi

echo -n " $Component : "

systemctl enable nginx  &>> $LOGFILE
systemctl daemon reload nginx &>>  $LOGFILE
systemctl start nginx  &>> $LOGFILE

if [ $? -eq 0 ] ; then
  echo -e "\e[31m success \e[0m"
else
  echo -e "\e[32m failure  \e[0m"
fi



echo -e "******\e[35m $COMPONENT configuration is completed \e[0m ******"
