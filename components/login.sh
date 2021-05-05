#!/bin/bash
source components/common.sh
OS_PREREQ
Head "Install Go Lang"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
STAT $?

HEAD "Set path variables"
export PATH=$PATH:/usr/local/go/bin
source ~/.profile
go version
STAT $?

HEAD "Make directory"
mkdir /go && cd /go && mkdir src && cd src

HEAD "Clone code from github"
DOWNLOAD_COMPONENT
STAT $?
cd ${COMPONENT}
Head "Export go path in directory"
export GOPATH=/go
HEAD "Build"
go build >>"${LOG}"
STAT $?

HEAD "Create login service file"
vi /etc/systemd/system/login.service


HEAD "Start login service"
systemctl daemon-reload && systemctl start login && systemctl status login
STAT $?
