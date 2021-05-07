#!/bin/bash
source components/common.sh
OS_PREREQ
Head "Install Go Lang"
apt  install golang-go &>>$LOG
STAT $?
DOWNLOAD_COMPONENT
STAT $?
Head "Export go path in directory"
go get github.com/dgrijalva/jwt-go
go get github.com/labstack/echo
go get github.com/labstack/echo/middleware
go get github.com/labstack/gommon/log
go get github.com/openzipkin/zipkin-go
go get github.com/openzipkin/zipkin-go/middleware/http
go get  github.com/openzipkin/zipkin-go/reporter/http
Head "Build"
go build &>>"${LOG}"
STAT $?
Head "Update USERS_API in Service File"
sed -i -e "s/USERSDNS/users.zsdevtraining.online/" /root/login/systemd.service
Stat $?

Head "Create login service file"
mv /root/login/systemd.service /etc/systemd/system/login.service

Head "Start login service"
systemctl daemon-reload && systemctl start login && systemctl status login
STAT $?
