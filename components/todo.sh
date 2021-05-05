#!/bin/bash

source components/common.sh
OS_PREREQ

Head "Installing npm"
apt install npm -y &>>$LOG

DOWNLOAD_COMPONENT

Head "Install npm"
npm install &>>$LOG
STAT $?

Head  "Create service file"
vi /etc/systemd/system/todo.service

Head "Start Todo Service"
systemctl daemon-reload && systemctl start todo && systemctl status todo
STAT $?
