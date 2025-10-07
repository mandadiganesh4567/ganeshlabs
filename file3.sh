#!/bin/bash

VALIDATE(){

  if [ $? -ne 0 ]
  then
    echo " $1 is failed"
    echo " $3 reason: "
  else  
    echo " $2 is success"
  fi
}
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
  VALIDATE $? "Listing Mysql" "may be dnf failed"
else  
  echo " alreday installed enjoy"
fi

dnf list installed git -y

if [ $? -ne 0 ]
then
  echo " installation faileed and sql not present"
  dnf install git -y
  VALIDATE $? "Listing git" "may be dnf failed"
else  
  echo " alreday installed enjoy"
fi