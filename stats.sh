#!/bin/bash

while true; do
#Monitory Bandwidth Developed by Adminlogs.info
#Tested and verified with CentOS and RedHat 5
hostname=`hostname`
vnstat -tr > /tmp/monitor
i=0
in=`cat /tmp/monitor | grep rx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
inx=$(($in + $i))
out=`cat /tmp/monitor | grep tx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
outx=$(($out + $i))

echo "$inx" 
echo "$outx"
 
##### Second Test after 2 minutes
sleep 30
vnstat -tr > /tmp/monitor2
ini2=`cat /tmp/monitor2 | grep rx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
inx2=$(($in2 + $i))
out2=`cat /tmp/monitor2 | grep tx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
outx2=$(($out2 + $i))

echo "$inx2" 
echo "$ourx2"

#### Third Test after 4 minutes
sleep 30
vnstat -tr > /tmp/monitor3
ini3=`cat /tmp/monitor3 | grep rx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
inx3=$(($in2 + $i))
out3=`cat /tmp/monitor3 | grep tx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
outx3=$(($out3 + $i))

echo "$inx3"
echo "$outx3"

done
