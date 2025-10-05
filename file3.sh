#!/bin/bash
Check_Install() {
sudo dnf install -y mysql

 if [ $? -eq 0 ]; then
    echo " sql installed success"
 else
   echo " Installing mysql Now"
 fi
}
Check_Install()