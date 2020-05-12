#!/bin/bash
#Monitory Bandwidth Developed by Adminlogs.info
#Tested and verified with CentOS and RedHat 5
hostname=`hostname`
vnstat -tr > /tmp/monitor
i=0
in=`cat /tmp/monitor | grep rx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
inx=$(($in + $i))
out=`cat /tmp/monitor | grep tx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
outx=$(($out + $i))
 
##### Second Test after 2 minutes
sleep 120
vnstat -tr > /tmp/monitor2
ini2=`cat /tmp/monitor2 | grep rx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
inx2=$(($in2 + $i))
out2=`cat /tmp/monitor2 | grep tx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
outx2=$(($out2 + $i))

#### Third Test after 4 minutes
sleep 120
vnstat -tr > /tmp/monitor3
ini3=`cat /tmp/monitor3 | grep rx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
inx3=$(($in2 + $i))
out3=`cat /tmp/monitor3 | grep tx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
outx3=$(($out3 + $i))

#### condition checking
[ $outx -ge 10 ] && [ $outx2 -ge 10 ] && [ $outx3 -ge 10 ]
out4=$?
if [ $out4 -eq 0 ]
then
cat /tmp/monitor /tmp/monitor2 /tmp/monitor2 >> /tmp/monitor_result
fi
#### clearing old results
> /tmp/monitor
> /tmp/monitor2
> /tmp/monitor3
> /tmp/monitor_result
