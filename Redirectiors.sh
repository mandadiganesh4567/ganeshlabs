#!/bin/bash

LOGS_FOLDER="/var/logs/script"
# SCRIPT_NAME now extracts only the base name
SCRIPT_NAME=$(basename $0 | cut -d "." -f1) 
TIMESTAMP=$(date +%F-%H-%M-%S) # Simplified date format
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

# --- Setup ---

# Log folder creation must be done before logging
# This works only if the script is run with sudo
mkdir -p $LOGS_FOLDER
R="\e[31m" # Red
G="\e[32m" # Green
N="\e[0m"  #
VALIDATE(){

  if [ $? -ne 0 ]
  then
    echo -e " $1 is $R failed $N" &>>$LOG_FILE
    echo " $3 reason: " &>>$LOG_FILE
  else  
    echo -e "$2 is $G success $N" &>>$LOG_FILE
  fi
}
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
  echo "its not in privillage mode run with privillage mode" &>>$LOG_FILE
  exit 1
fi


for package in $@
do
    dnf list installed $package -y

    if [ $? -ne 0 ]
    then
      echo -e " $R installation faileed and sql not present$N" &>>$LLOG_FILE
      dnf install $package -y
      VALIDATE $? "Listing $package" "may be dnf failed" &>>$LOG_FILE
    else  
      echo -e "$G $package alreday installed enjoy$N" &>>$LOG_FILE
    fi
done