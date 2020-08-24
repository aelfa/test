#!/usr/bin/with-contenv bash
# shellcheck shell=bash
# Copyright (c) 2020, MrDoob
# All rights reserved.
# cleanup remotes based of rclone.conf file
# only clean remotes thats inside the rclone.conf 

## function source start
IFS=$'\n'
filter="$1"
config=/config/rclone.conf
#rclone listremotes | gawk "$filter"
mapfile -t mounts < <(eval rclone listremotes --config=${config} | grep "$filter" | sed -e 's/[GDSA00-99C:]//g' | sed '/^$/d')
## function source end


for i in ${mounts[@]}; do
  echo; echo STARTING DEDUPE of identical files from $i; echo
  rclone dedupe skip $i: -v --config=${config} --drive-use-trash=false --no-traverse --transfers=50
  echo; echo REMOVING EMPTY DIRECTORIES from $i; echo
  rclone rmdirs $i: -v --config=${config} --drive-use-trash=false --fast-list --transfers=50
  echo; echo PERMANENTLY DELETING TRASH from $i; echo
  rclone delete $i: --config=${config} --fast-list --drive-trashed-only --drive-use-trash=false -v --transfers 50
  rclone cleanup $i: -v --config=${config}
done
