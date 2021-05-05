#!/bin/bash
source components/common.sh
OS_PREREQ
Head "Install Go Lang"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
STAT $?

Head "Set path variables"
export PATH=$PATH:/usr/local/go/bin
source ~/.profile
go version
STAT $?

Head "Make directory"
mkdir /go && cd /go && mkdir src && cd src

DOWNLOAD_COMPONENT
STAT $?
Head "Export go path in directory"
export GOPATH=/go
Head "Build"
go build >>"${LOG}"
STAT $?

Head "Create login service file"
vi /etc/systemd/system/login.service


Head "Start login service"
systemctl daemon-reload && systemctl start login && systemctl status login
STAT $?
