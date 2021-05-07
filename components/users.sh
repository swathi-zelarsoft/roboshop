#!/bin/bash

source components/common.sh
OS_PREREQ
STAT $?
Head "check java version"
java -version
Head "install java 8 version"
apt-get install openjdk-8-jdk -y &>>${LOG}
STAT $?
Head "Install maven"
apt install maven -y &>>$LOG
STAT $?

DOWNLOAD_COMPONENT
STAT $?

Head "Create package"
mvn clean package &>>$LOG
STAT $?

Head "Create Users Service"
mv /root/todoshell/users/systemd.service /etc/systemd/system/users.service
STAT $?

Head "Start users service"
systemctl daemon-reload && systemctl start users && systemctl status users
STAT $?
