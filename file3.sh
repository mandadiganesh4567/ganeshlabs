#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]
then
  echo "its not in privillage mode run with privillage mode"
  exit 1
fi

dnf list installed mysql -y


if [ $? -ne 0 ]
then
  echo " installation faileed and sql not present"
  dnf install mysql -y
else  
  echo " alreday installed enjoy"
fi