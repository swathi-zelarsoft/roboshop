#!/bin/bash

source components/common.sh
OS_PREREQ
Head "Installing Nginx"
apt install nginx -y &>>"$LOG"
systemctl start nginx
Head "Installing npm"
apt install npm -y &>>$LOG

Head "Downloading git file"
cd /var/www/html
DOWNLOAD_COMPONENT
cd ${COMPONENT}
Head "Install Npm"
npm install >>"${LOG}"
STAT $?
Head "Run build"
npm run build >>${LOG}
killall node >>"${LOG}"
npm run build
STAT $?
Head "Change root path in nginx"
cd /etc/nginx/sites-available || exit
vi default
STAT $?
Head "Update index.js File With Todo & Login Ip"
cd /var/www/html/frontend && cd config || exit
vi index.js
STAT $?
Head "Restart Nginx"
systemctl restart nginx
STAT $?
Head "run npm start"
npm start
STAT $?