#!/bin/bash
var1="ganesh"
var2="Gemini Ai"
date=$(date)
echo "new learner is : $var1+$var2"
echo "$var1  saying Thanks alot !!!! to $var2 at $date"

DISK_USAGE="85"
if [ $DISK_USAGE -gt 90 ]
then
echo "Critical alert! Disk space running low."
else
echo "Disk fine"
fi