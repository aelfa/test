#!/usr/bin/with-contenv bash
# shellcheck shell=bash
# Copyright (c) 2020, MrDoob
# All rights reserved.

function sudocheck() {
if [[ $EUID -ne 0 ]]; then
    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  You Must Execute as a SUDO USER (with sudo) or as ROOT!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  exit 0
  else
  reatart
fi
}

function reatart() {
### stop section
container=$(docker ps -aq --format '{{.Names}}' | sed '/^$/d' | grep -E 'ple|arr|emby|jelly') 
docker stop $container >> /dev/null
echo " stop $container"
sleep 3
IFS=$'\n'
filter="$1"
config=/opt/appdata/plexguide/rclone.conf
mapfile -t mounts < <(eval rclone listremotes --config=${config} | grep "$filter" | sed -e 's/://g' | sed '/GDSA/d' | sort -r)
##### Stop MOUNT #####
for i in ${mounts[@]}; do
    service $i stop
    if [[ $i == "pgunion" ]]; then
       fusermount -uzq /mnt/unionfs
    else
       fusermount -uzq /mnt/$i
    fi
    sleep 1
done
#### restart section
IFS=$'\n'
filter="$1"
config=/opt/appdata/plexguide/rclone.conf
mapfile -t mounts < <(eval rclone listremotes --config=${config} | grep "$filter" | sed -e 's/://g' | sed '/pgunion/d' | sed '/GDSA/d' | sort -r)
##### Start MOUNT #####
for i in ${mounts[@]}; do
    sudo service $i start && sleep 0.5
done
sleep 3
service pgunion start
sleep 5
container=$(docker ps -aq --format '{{.Names}}' | sed '/^$/d' | grep -E 'ple|arr|emby|jelly')
docker start $container >> /dev/null
echo "starting $container"
}

sudocheck

#<EOF>#
