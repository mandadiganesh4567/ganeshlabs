#!/bin/bash

Validate(){

  if [ $? -ne 0 ]
  then
    echo " $1 is failed"
    echo " $3 reason: "
  else  
    echo " $2 is success"
}
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
  echo "its not in privillage mode run with privillage mode"
  exit 1
fi

dnf list installed mysql -y
VALIDATE $? "Listing Mysql" "may be dnf failed"
dnf list installed git -y
VALIDATE $? "Listing git" "may be dnf failed"
#if [ $? -ne 0 ]
# then
#   echo " installation faileed and sql not present"
#   dnf install mysql -y
# else  
#   echo " alreday installed enjoy"
# fi