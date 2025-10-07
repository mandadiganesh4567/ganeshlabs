#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]
then
  echo "its not in privillage mode run with privillage mode"
else
  echo "its in privillage mode"

fi

dnf install mysql -y


