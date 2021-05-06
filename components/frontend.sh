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
STAT $?
Head "Change root path in nginx"
sed -i -e 's+/var/www/html+/var/www/html/frontend/dist+g' /etc/nginx/sites-available/default
STAT $?
Head "Now export login and todo Ip's"
export AUTH_API_ADDRESS=http://login.zsdevtraining.online:8080
export TODOS_API_ADDRESS=http://todo.zsdevtraining.online:8080
STAT $?
Head "Restart Nginx"
systemctl restart nginx
STAT $?
Head "run npm start"
npm start
STAT $?