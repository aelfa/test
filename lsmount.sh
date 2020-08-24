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
mapfile -t mounts < <(eval rclone listremotes --config=${config} | grep "$filter" | sed -e 's/[pgunion:]//g' | sed -e 's/[GDSA00-99C:]//g' | sed '/^$/d')
## function source end

DIR_CACHE_TIME=${DIR_CACHE_TIME:-2m}
VFS_READ_CHUNK_SIZE=${VFS_READ_CHUNK_SIZE:-96M}
VFS_CACHE_MAX_AGE=${VFS_CACHE_MAX_AGE:-675h}
VFS_READ_CHUNK_SIZE_LIMIT=${VFS_READ_CHUNK_SIZE_LIMIT:-1G}
VFS_CACHE_MODE=${VFS_CACHE_MODE:-writes}
VFS_CACHE_MAX_SIZE=${VFS_CACHE_MAX_SIZE:-10G}
BUFFER_SIZE=${BUFFER_SIZE:-48M}
RC_ENABLED=${RC_ENABLED:-false}
RC_ADDR=${RC_ADDR:-0.0.0.0:25975}
RC_USER=${RC_USER:-user}
RC_PASS=${RC_PASS:-xxx}
POLL_INTERVAL=${POLL_INTERVAL:-5m}
LOGLEVEL=${LOGLEVEL}
UAGENT=${UAGENT}


# These flags are applied to all sets. Tweak them as you like
FLAGS="
  --config=${config}
  --log-file=/logs/drive/rclone-{$i}.log \
  --log-level=${LOFLEVEL}
  --uid=1000 --gid=1000 --umask=002
  --allow-other
  --timeout=1h
  --tpslimit=8
  --drive-skip-gdocs
  --user-agent=${UAGENT}
  --dir-cache-time=${DIR_CACHE_TIME}
  --vfs-cache-mode=${VFS_CACHE_MODE}
  --vfs-cache-max-age=${VFS_CACHE_MAX_AGE}
  --vfs-cache-max-size=${VFS_CACHE_MAX_SIZE}
  --vfs-read-chunk-size-limit=${VFS_READ_CHUNK_SIZE_LIMIT}
  --vfs-read-chunk-size=${VFS_READ_CHUNK_SIZE}
  --buffer-size=${BUFFER_SIZE}
  --fast-list
  --tpslimit-burst=50
  --stats=10s
  --max-backlog=2000000
  --ignore-case
  --no-update-modtime
  --drive-chunk-size=128M
  --drive-use-trash=false
  --track-renames
  --use-mmap
  --drive-server-side-across-configs=true
  --drive-stop-on-upload-limit
  "
for i in ${mounts[@]}; do
  echo; echo CREATE EMPTY DIRECTORIES for $i; echo
  mkdir -p /mnt/${i}
  #if [ size command here for check ]; then  when failes.
  #   echo; echo CHECK FOR EMPTY MOUNTS & DIRECTORIES for $i; echo
  #   /bin/fusermount -uz /mnt/${i} > /dev/null
  #fi
  echo; echo STARTING MOUNT of from $i; echo
  /bin/rclone mount $i: -v --config=${config} ${FLAGS} /mnt/{$i}
  echo; echo REMOVING EMPTY DIRECTORIES from $i; echo
done

## }} ##
  ## then merger command ##
## {{ ##
