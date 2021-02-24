#!/usr/bin/with-contenv bash
# shellcheck shell=bash
# Copyright (c) 2020, MrDoob
# All rights reserved.
# 

## function source start
IFS=$'\n'
> /home/mount.sizes
filter=$1
## function source end

if [[ -f "/home/mount.sizes" ]]; then
   rm -f /home/mount.sizes
fi

config=/opt/appdata/mount/rclone.conf
mapfile -t mounts < <(eval rclone listremotes --config=${config} | grep "$filter" | sed '/GDSA/d' | sed '/pgunion/d')
## function source end

for i in ${mounts[@]}; do
  echo For $i Drive/Folder Scan is running
  echo "" >> /home/mount.sizes 
  echo For $i >> /home/mount.sizes
  rclone size $i --config=${config} --fast-list >> /home/mount.sizes
done
CC2=/home/mount.sizes
if [[ -f "$CC2" ]]; then
endline=$(cat /home/mount.sizes)
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━
     💪  Rclone size check done
━━━━━━━━━━━━━━━━━━━━━━━━

 $endline

━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -rp '↘️ Press [ENTER] to quit ' typed </dev/tty
fi
