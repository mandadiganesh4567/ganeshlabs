#!/bin/bash

LOging="/var/logs/script"
Timestamp=$(date +%H%M%S)

# Extract the script name without the extension using 'cut'
# $0 is the name of the script. We pipe it to 'cut' to use the dot '.' as a delimiter
# and take the first field (-f1).
Name=$(echo "$0" | cut -d "." -f1 ) # A more complete cut 

# Full path to the log file (Note the use of '/' for a path separator)
LogFile="$LOging/$Name-$Timestamp.log"

# --- Directory Creation ---
# Create the log directory if it doesn't exist (Note the '$' for variable reference)
mkdir -p "$LOging" 
R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){

  if [ $? -ne 0 ]
  then
    echo -e " $1 is $R failed $N" &>>LogFilee
    echo " $3 reason: "
  else  
    echo -e "$2 is $G success $N" &>>LogFilee
  fi
}
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
  echo "its not in privillage mode run with privillage mode" &>>LogFilee
  exit 1
fi


for package in $@
do
    dnf list installed $package -y

    if [ $? -ne 0 ]
    then
      echo -e " $R installation faileed and sql not present$N" &>>LogFilee
      dnf install $package -y
      VALIDATE $? "Listing $package" "may be dnf failed" &>>LogFilee
    else  
      echo -e "$G $package alreday installed enjoy$N" &>>LogFilee
    fi
done

dnf list installed git -y

if [ $? -ne 0 ]
then
  echo -e " $R installation faileed and sql not present$N" &>>LogFilee
  dnf install git -y
  VALIDATE $? "Listing git" "may be dnf failed" &>>LogFilee
else  
  echo -e " $G alreday installed enjoy$N" &>>LogFilee
fi