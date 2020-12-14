#!/bin/bash

apt-get install ethtool vnstat vnstati -yqq 2>&1 >>/dev/null
export DEBIAN_FRONTEND=noninteractive
network=$(ifconfig | grep -E 'eno1|enp|ens5' | awk '{print $1}' | sed -e 's/://g')
sed -i 's/eth0/'$network'/g' /etc/vnstat.conf
sed -i '/UseLogging/s/2/0/' /etc/vnstat.conf
sed -i '/RateUnit/s/1/0/' /etc/vnstat.conf
sed -i '/UnitMode/s/0/1/' /etc/vnstat.conf
sed -i 's/Locale "-"/Locale "LC_ALL=en_US.UTF-8"/g' /etc/vnstat.conf
/etc/init.d/vnstat restart 2>&1 >>/dev/null

echo "done"
sudo docker restart uploader

sleep 1
exit
