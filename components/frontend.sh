#!/bin/bash

source components/common.sh
OS_PREREQ
Head "Installing Nginx"
apt install nginx -y &>>$LOG
systemctl start nginx
Head "Installing npm"
apt install npm -y &>>$LOG
Head"Start nginx service"

Head "Downloading git file"
cd /var/www/html
DOWNLOAD_COMPONENT
cd ${COMPONENT}
npm install
npm run build
