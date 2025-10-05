#!/bin/bash
Check_Install() {
sudo dnf install -y mysql

 if [ $? -eq 0 ];
    echo " sql installed success"
 else
   echo " Installing mysql Now"
}
Check_Install()