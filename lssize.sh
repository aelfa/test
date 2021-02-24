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

config=/opt/appdata/mount/config/rclone-docker.conf
mapfile -t mount < <(eval rclone listremotes --config=${config} | grep "$filter" | sed '/GDSA/d' | sed '/pgunion/d')
## function source end

for i in ${mounts[@]}; do
  echo; echo For $i | tee -a mount.sizes
  rclone size $i: --config=${config} --fast-list | tee -a /home/mount.sizes
done

