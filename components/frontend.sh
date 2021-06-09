#!/bin/bash

source components/common.sh
OS_PREREQ
Head "Installing Nginx"
apt install nginx -y &>>"$LOG"
systemctl start nginx
STAT $?
Head "Installing npm"
apt install npm -y &>>$LOG
STAT $?
Head "Downloading git file"
cd /var/www/html

DOWNLOAD_COMPONENT
Head "Install Npm"
npm install && npm install --save-dev node-sass &>>$LOG
STAT $?
Head "Run build"
npm run build &>>${LOG}
STAT $?
Head "Remove default files"
rm -rf /var/www/html/index.debian.html /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default
STAT $?
Head "Now update todo.conf file in sites-enabled"
mv /var/www/html/frontend/todo.conf /etc/nginx/sites-enabled/todo.conf
Head "Restart Nginx"
systemctl restart nginx
STAT $?

Head "Create frontend service file"
mv /var/www/html/frontend/systemd.service /etc/systemd/system/frontend.service
STAT $?
Head "Start the frontend service"
systemctl daemon-reload && systemctl start frontend && systemctl status frontend
STAT $?