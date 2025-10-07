#!/bin/bash


R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){

  if [ $? -ne 0 ]
  then
    echo -e " $1 is $R failed $N"
    echo " $3 reason: "
  else  
    echo -e "$2 is $G success $N"
  fi
}
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
  echo "its not in privillage mode run with privillage mode"
  exit 1
fi


for package in $@
do
    dnf list installed $package -y

    if [ $? -ne 0 ]
    then
      echo -e " $R installation faileed and sql not present$N"
      dnf install $package -y
      VALIDATE $? "Listing $package" "may be dnf failed"
    else  
      echo -e "$G $package alreday installed enjoy$N"
    fi
done

# dnf list installed git -y

# if [ $? -ne 0 ]
# then
#   echo -e " $R installation faileed and sql not present$N"
#   dnf install git -y
#   VALIDATE $? "Listing git" "may be dnf failed"
# else  
#   echo -e " $G alreday installed enjoy$N"
# fi