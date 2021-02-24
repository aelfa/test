#!/usr/bin/with-contenv bash
# shellcheck shell=bash
# Copyright (c) 2020, MrDoob
# All rights reserved.
# 

## function source start
IFS=$'\n'
> mount.sizes
filter=$1
## function source end

config=/opt/appdata/mount/rclone.conf
mapfile -t mount < <(eval rclone listremotes --config=${config} | grep "$filter" | sed '/GDSA/d' | sed '/pgunion/d')
## function source end

for i in ${mounts[@]}; do
  echo; echo For $i | tee -a mount.sizes
  rclone size $i --config=${config} --fast-list | tee -a /home/mount.sizes
done
rcc=/home/mount.sizes
if [[ -f "$rcc" ]]; then
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
