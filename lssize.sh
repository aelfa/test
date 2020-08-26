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

config=/config/rclone.conf
#rclone listremotes | gawk "$filter"
mapfile -t mounts < <(eval rclone listremotes --config=${config} | grep "$filter" | sed -e 's/[GDSA00-99C:]//g' | sed '/^$/d')
## function source end

for i in ${mounts[@]}; do
  echo; echo For $i | tee -a mount.sizes
  rclone size $i --config=${config} --fast-list | tee -a mount.sizes
done
