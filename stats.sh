#!/bin/bash
while true; do

##### First Test
vnstat -tr > /tmp/monitor
i=0
in=`cat /tmp/monitor | grep rx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
inx1=$(($in + $i))
out=`cat /tmp/monitor | grep tx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
outx1=$(($out + $i))

echo " ~~~~~~~~~~~~~~~~~~~~"
echo " INCOMING : ${inx1}" 
echo " OUTGOING : ${outx1}"
echo " ~~~~~~~~~~~~~~~~~~~~" 

##### Second Test
sleep 30
vnstat -tr > /tmp/monitor2
in2=`cat /tmp/monitor2 | grep rx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
inx2=$(($in2 + $i))
out2=`cat /tmp/monitor2 | grep tx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
outx2=$(($out2 + $i))

echo " INCOMING : ${inx2}" 
echo " OUTGOING : ${outx2}"
echo " ~~~~~~~~~~~~~~~~~~~~"

#### Third Test
sleep 30
vnstat -tr > /tmp/monitor3
in3=`cat /tmp/monitor3 | grep rx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
inx3=$(($in3 + $i))
out3=`cat /tmp/monitor3 | grep tx | grep -v kbit | awk '{print $2}' | cut  -d . -f1`
outx3=$(($out3 + $i))

echo " INCOMING : ${inx3}" 
echo " OUTGOING : ${outx3}"
echo " ~~~~~~~~~~~~~~~~~~~~"

echo "     TEST 1 "
echo " INCOMING : ${inx1}" 
echo " OUTGOING : ${outx1}"
echo "     TEST 2 "
echo " INCOMING : ${inx2}" 
echo " OUTGOING : ${outx2}"
echo "     TEST 3 "
echo " INCOMING : ${inx3}" 
echo " OUTGOING : ${outx3}"
echo "    3 TESTS DONE " 
echo " ~~~~~~~~~~~~~~~~~~~~"
done
exit0
