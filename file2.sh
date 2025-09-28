#!/bin/bash
var1="$1"
var2="$2"
date=$(date)
echo "new learner is : $var1+$var2"
echo "$var1  saying Thanks alot !!!! to $var2 at $date"
read -p " provide if you havent pass arguments $@"

DISK_USAGE="85"
if [ $DISK_USAGE -gt 90 ]; then
    echo "Critical alert! Disk space running low."
else
    echo "Disk fine"
fi