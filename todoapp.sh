#!/bin/bash

COMPONENT=$1
source components/common.sh

if [! -f components/${COMPONENT}.sh ]; then
  echo -e "\e[31mInvalid component name\e[0m"
  exit 1
  fi
  USER_NAME =$(whoami)
  if ($"{USER_NAME}" != "root");then
  echo "\e[32mYou should be in root to perform this script\e[0m"
  exit
  fi

  export COMPONENT
  bash components/${COMPONENT}.sh