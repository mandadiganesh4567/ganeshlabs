#!/bin/bash
var1="$1"
var2="$2"
date=$(date)
#if [ -z "$var1" ] || [  -z "$var2" ]; then
    read -p "give name 1:" var1 
    read -p "give name 2:" var2 
#fi
echo "new learner is : $var1"
echo "$var1  saying Thanks alot !!!! to $var2 at $date"


DISK_USAGE="85"
if [ "$DISK_USAGE" -gt 90 ]; then
    echo "Critical alert! Disk space running low."
else
    echo "Disk fine"
fi