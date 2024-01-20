#!/bin/bash


USER_ID=$(id -u)
COMPONENT="catalogue"
COMPONENT_URL="https://github.com/stans-robot-project/catalogue/archive/main.zip"
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"
APPUSER_HOME="/home/${APPUSER}/${COMPONENT}"


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
   echo -e "\e[35m skipping \e[0m"
fi 

echo -n "Downloading $COMPONENT ;"
curl -s -L -o /tmp/$COMPONENT.zip $COMPONENT_URL
stat $?

#echo -n "Performing cleanup of  $COMPONENT ;"
#rm -rf $APPUSER_HOME & >> $LOGFILE



echo -n "Extracting $COMPONENT ;"
cd /home/roboshop
unzip /tmp/${COMPONENT}.zip   &>> $LOGFILE
stat $?


echo -n "Configuring  $COMPONENT the Permission :"
mv ${APPUSER_HOME}-main $APPUSER_HOME
chown -R $APPUSER:$APPUSER $APPUSER_HOME
chmod -R 770  $APPUSER_HOME
stat $?

echo -n "Generating  Artifacts ; "
cd $APPUSER_HOME
npm install &>> $LOGFILE
stat $?


echo -n "Configuring  $COMPONENT sysdtemd file ;"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' ${APPUSER_HOME}/systemd.service
mv ${APPUSER_HOME}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting  $COMPONENT service  ;"
systemctl daemon reload &>>  $LOGFILE
systemctl enable $COMPONENT  &>> $LOGFILE
systemctl restart $COMPONENT  &>> $LOGFILE
stat $?


echo -e "******\e[35m $COMPONENT configuration is completed \e[0m ******"



