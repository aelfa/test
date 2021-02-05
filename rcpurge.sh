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
fi
}
function rctest() {
if [[ $(command -v rclone) == "" ]]; then
    tee <<-EOF
━━━━━━━━━━━━━
⛔️  rclone not found 
━━━━━━━━━━━━━
EOF
  exit 0
fi
}
function rcpurge() {
IFS=$'\n'
filter="$1"
config=/opt/appdata/plexguide/rclone.conf
mapfile -t mounts < <(eval rclone listremotes --config=${config} | grep "$filter" | sed -e 's/://g' | sed '/pgunion/d' | sed '/GDSA/d' | sort -r)
##### RUN MOUNT #####
for i in ${mounts[@]}; do
  echo "rclone rmdirs running for $i"
  rclone rmdirs $i: \
       --drive-use-trash=false \
       --fast-list --transfers=50 \
       --config=${config}
  echo "rclone rmdirs done for $i"
done
}


sudocheck
rctest
rcpurge
