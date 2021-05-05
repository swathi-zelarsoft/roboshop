#!/bin/bash

source components/common.sh

Head "Set hostname and update repo"
OS_PREREQ

Head "Check java version and install java 8 version"
apt-get remove openjdk-11-jdk-headless >>$LOG
apt-get install openjdk-8-jdk >>"${LOG}"
STAT $?

Head "Install maven"
apt install maven -y >>$LOG
STAT $?



DOWNLOAD_COMPONENT
STAT $?

Head "Create package"
mvn clean package
STAT $?

Head "Create Users Service"
vi /etc/systemd/system/users.service

Head "Start users service"
systemctl daemon-reload && systemctl start users && systemctl enable users
STAT $?
