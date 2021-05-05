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
HEAD "Install Npm"
npm install >>"${LOG}"
STAT $?
HEAD "Run build"
npm run build >>${LOG}
killall node >>"${LOG}"
npm run build
STAT $?
HEAD "Change root path in nginx"
cd /etc/nginx/sites-available || exit
vi default
STAT $?
HEAD "Update index.js File With Todo & Login Ip"
cd /var/www/html/frontend && cd config || exit
vi index.js
STAT $?
HEAD "Restart Nginx"
systemctl restart nginx
STAT $?
HEAD "run npm start"
npm start
STAT $?