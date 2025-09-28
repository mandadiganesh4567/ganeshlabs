#!/bin/bash
var1="g"
var2="A"
date=$(date)

CHECK() {
if [ -z "$var1" ] || [  -z "$var2" ]; then
    echo "provide name"
    read -p "give name 1:" var1 
    read -p "give name 2:" var2 
else 
    echo " ignore"
fi
}
CHECK
echo "new learner is : $var1"
echo "$var1  saying Thanks alot !!!! to $var2 at $date"

DISK_USAGE="85"
if [ "$DISK_USAGE" -gt 90 ]; then
    echo "Critical alert! Disk space running low."
else
    echo "Disk fine"
fi
