#!/bin/bash
Head(){
  echo -e "\e[36m  ============ $1 ===========\e[0m"
}
LOG=/tmp/${COMPONENT}.log
rm -r $LOG
OS_PREREQ(){
  set-hostname component/$COMPONENT
  Head " Updating the repos "
  apt update &>$LOG
  }
ERROR(){
  echo -e "\e[1;31m$1\e[0m"
}