#!/bin/bash
LOG=/tmp/${COMPONENT}.log
rm -r $LOG
Head(){
  echo -e "\e[36m  ============ $1 ===========\e[0m"
  echo -e "\e[36m  ============ $1 ===========\e[0m" >>$LOG
}

OS_PREREQ(){
  set-hostname component/$COMPONENT
  Head " Updating the repos "
  apt update &>>$LOG
  }
ERROR(){
  echo -e "\e[1;31m$1\e[0m"
}
DOWNLOAD_COMPONENT()
{
  Head "Downloading ${COMPONENT} component"
git clone "https://github.com/zelar-soft-todoapp/${COMPONENT}.git"
}