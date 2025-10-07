#!/bin/bash

LOGS_FOLD="/var/logs/script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1 ) 
TIMESTAMP=$(date +%Y-%m-%D-%H-%M-%S)
LOG_FIL=$LOGS_FOLD/$SCRIPT_NAME-$TIMESTAMP.log

mkdir -p /var/logs/script
R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){

  if [ $? -ne 0 ]
  then
    echo -e " $1 is $R failed $N" &>>LOG_FIL
    echo " $3 reason: " &>>LOG_FIL
  else  
    echo -e "$2 is $G success $N" &>>LOG_FIL
  fi
}
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
  echo "its not in privillage mode run with privillage mode" &>>LOG_FIL
  exit 1
fi


for package in $@
do
    dnf list installed $package -y

    if [ $? -ne 0 ]
    then
      echo -e " $R installation faileed and sql not present$N" &>>LOG_FIL
      dnf install $package -y
      VALIDATE $? "Listing $package" "may be dnf failed" &>>LOG_FIL
    else  
      echo -e "$G $package alreday installed enjoy$N" &>>LOG_FIL
    fi
done