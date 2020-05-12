#!/bin/bash

while true; do
hostname=`hostname`

vnstat -tr > /tmp/monitor
i=0
in=`cat /tmp/monitor | grep rx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
inx1=$(($in + $i))
out=`cat /tmp/monitor | grep tx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
outx1=$(($out + $i))

echo "INCOMING : ${inx1}" 
echo "OUTGOING : ${outx1}"
 
##### Second Test
sleep 30
vnstat -tr > /tmp/monitor2
ini2=`cat /tmp/monitor2 | grep rx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
inx2=$(($in2 + $i))
out2=`cat /tmp/monitor2 | grep tx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
outx2=$(($out2 + $i))

echo "INCOMING : ${inx2}" 
echo "OUTGOING : ${outx2}"

#### Third Test
sleep 30
vnstat -tr > /tmp/monitor3
ini3=`cat /tmp/monitor3 | grep rx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
inx3=$(($in2 + $i))
out3=`cat /tmp/monitor3 | grep tx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
outx3=$(($out3 + $i))

echo "INCOMING : ${inx3}" 
echo "OUTGOING : ${outx3}"

done

echo " TEST 1 "
echo "INCOMING : ${inx1}" 
echo "OUTGOING : ${outx1}"
echo " TEST 2 "
echo "INCOMING : ${inx2}" 
echo "OUTGOING : ${outx2}"
echo " TEST 3 "
echo "INCOMING : ${inx3}" 
echo "OUTGOING : ${outx3}"
echo " 3 TESTS DONE " 
