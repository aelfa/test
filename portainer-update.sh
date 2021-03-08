#!/usr/bin/with-contenv bash
# shellcheck shell=bash
# Copyright (c) 2020, MrDoob
# All rights reserved

sudo docker ps -a -q --format '{{.Names}}' | sort | sed -e 's/portainer//g' | sed '/^$/d' >> /tmp/stopdockers
containers=$(cat /tmp/stopdockers)
for container in $containers; do
    echo " -->> Stopping $container <<-- "
    sudo docker stop $container >> /dev/null
done
sleep 5
cd /opt/coreapps/apps/

sudo wget https://raw.githubusercontent.com/doob187/test/master/portainer-ce.yml  && 
sudo ansible-playbook /opt/coreapps/apps/portainer-ce.yml 

sleep 5

sudo docker ps -a -q --format '{{.Names}}' | sort | sed -e 's/portainer//g' | sed '/^$/d' >> /tmp/startdockers
containers=$(cat /tmp/startdockers)
for container in $containers; do
    echo " -->> Starting $container <<-- "
    sudo docker start $container >> /dev/null
done

echo " all done " 
sudo rm -f /opt/coreapps/apps/portainer.yml
sudo mv /opt/coreapps/apps/portainer-ce.yml /opt/coreapps/apps/portainer.yml

exit 0
