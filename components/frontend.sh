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
npm install &>>"${LOG}"
STAT $?
Head "Run build"
npm run build &>>${LOG}
npm install --save-dev node-sass &>>$LOG
STAT $?
Head "Change root path in nginx"
sed -i -e 's+/var/www/html+/var/www/html/frontend/dist+g' /etc/nginx/sites-available/default
STAT $?
Head "Restart Nginx"
systemctl restart nginx
STAT $?

Head "Create login service file"
mv /root/var/www/html/frontend/systemd.service /etc/systemd/system/frontend.service
STAT $?
Head "Start the frontend service"
systemctl daemon-reload && systemctl start frontend && systemctl status frontend
STAT $?