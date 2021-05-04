#!/bin/bash
LOG=/tmp/${COMPONENT}.log
rm -r $LOG
Head(){
  echo -e "\e[36m  ============ $1 ===========\e[0m"
  echo -e "\e[36m  ============ $1 ===========\e[0m" >>$LOG
}

OS_PREREQ(){
  set-hostname component/${COMPONENT}
  Head " Updating the repos "
  apt update &>>$LOG
  }

STAT(){
  if [ "${1}" -eq 0 ]; then
    echo -e "\e[1;32m SUCCESS\e[0m"
  else
    echo -e "\e[1;31m FAILURE\e[0m"
    echo  -e "\e[1m;31m Pls refer log file for more information, log filepath is =${LOG}\e[0m"
  fi
}

ERROR(){
  echo -e "\e[1;31m$1\e[0m"
}
DOWNLOAD_COMPONENT(){
  Head "Downloading ${COMPONENT} component"
git clone "https://github.com/zelar-soft-todoapp/${COMPONENT}.git"
}