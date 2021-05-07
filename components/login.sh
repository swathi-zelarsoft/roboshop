#!/bin/bash
source components/common.sh
OS_PREREQ
Head "Install Go Lang"
wget -c https://dl.google.com/go/go1.15.5.linux-amd64.tar.gz -O -| sudo tar -xz -C /usr/local
STAT $?

Head "Set path variables"
export PATH=$PATH:/usr/local/go/bin
source ~/.profile
go version
STAT $?

Head "Make directory"
mkdir -p /go && cd /go && mkdir src && cd src

DOWNLOAD_COMPONENT
STAT $?
Head "Export go path in directory"
export GOPATH=/go
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
sed -i -e "s/USERSDNS/users.zsdevtraining.online/" /go/src/login/systemd.service
Stat $?

Head "Create login service file"
mv /go/src/login/systemd.service /etc/systemd/system/login.service

Head "Start login service"
systemctl daemon-reload && systemctl start login && systemctl status login
STAT $?
