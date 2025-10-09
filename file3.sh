#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

mkdir -p $LOGS_FOLDER
R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){

  if [ $? -ne 0 ]
  then
    echo -e " $1 is $R failed $N" &>>LOG_FILE
    echo " $3 reason: "
  else  
    echo -e "$2 is $G success $N" &>>LOG_FILE
  fi
}
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
  echo "its not in privillage mode run with privillage mode" &>>LOG_FILE
  exit 1
fi


for package in $@
do
    dnf list installed $package -y

    if [ $? -ne 0 ]
    then
      echo -e " $R installation faileed and sql not present$N" &>>LOG_FILE
      dnf install $package -y
      VALIDATE $? "Listing $package" "may be dnf failed" &>>LOG_FILE
    else  
      echo -e "$G $package alreday installed enjoy$N" &>>LOG_FILE
    fi
done

dnf list installed git -y

if [ $? -ne 0 ]
then
  echo -e " $R installation faileed and sql not present$N" &>>LOG_FILE
  dnf install git -y
  VALIDATE $? "Listing git" "may be dnf failed" &>>LOG_FILE
else  
  echo -e " $G alreday installed enjoy$N" &>>LOG_FILE
fi