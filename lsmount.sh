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
LOGLEVEL=${LOGLEVEL:-INFO}
UAGENT=${UAGENT:-somerandstring}
SMOUNT=/config/mount-scripts

if [ ! -d ${SMOUNT} ]; then
   mkdir -p ${SMOUNT} && chown -hR abc:abc ${SMOUNT} && chmod -R 775 ${SMOUNT}
else
   chown -hR abc:abc ${SMOUNT} && chmod -R 775 ${SMOUNT}
fi

## RUN MOUNT ##
for i in ${mounts[@]}; do
  if [ "$(ls /mnt/$i | wc -l)" -gt 1 ]; then     
     echo; echo CREATE EMPTY DIRECTORIES $i; echo
     mkdir -p /mnt/$i
     chown -hR abc:abc /mnt/$i
     chmod -R 775 /mnt/$i
  fi
  if [ "$(ls /mnt/$i | wc -l)" -gt 1 ]; then     
    echo; echo UNMOUNTING $i; echo
    fusermount -uzq /mnt/$i
  fi
  if [ -f "${SMOUNT}/$i-mount.sh" ]; then
     echo; echo REMOVE Script $i; echo
     rm -f "${SMOUNT}/$i-mount.sh"
  fi
  echo; echo CREATE $i LOGFOLDER; echo
  mkdir -p /logs && mkdir -p /logs/$i/
  chmod -R 775 /logs/ && chown -hR abc:abc /logs/
  touch /logs/$i/rclone-$i.log
  echo; echo CREATE MOUNT COMMAND $i; echo
  echo "rclone mount $i: /mnt/$i \
         --config=${config} \
         --log-file=/logs/$i/rclone-$i.log \
         --log-level=${LOGLEVEL} \
         --uid=1000 --gid=1000 --umask=002 \
         --allow-other --timeout=1h --tpslimit=8 \
         --drive-skip-gdocs --user-agent=${UAGENT} \
         --dir-cache-time=${DIR_CACHE_TIME} \
         --vfs-cache-mode=${VFS_CACHE_MODE} \
         --vfs-cache-max-age=${VFS_CACHE_MAX_AGE} \
         --vfs-cache-max-size=${VFS_CACHE_MAX_SIZE} \
         --vfs-read-chunk-size-limit=${VFS_READ_CHUNK_SIZE_LIMIT} \
         --vfs-read-chunk-size=${VFS_READ_CHUNK_SIZE} \
         --buffer-size=${BUFFER_SIZE} --fast-list \
         --drive-chunk-size=128M --drive-use-trash=false \
         --drive-server-side-across-configs=true \
         --drive-stop-on-upload-limit & " >> ${SMOUNT}/$i-mount.sh
         chmod 775 ${SMOUNT}/$i-mount.sh && chown abc:abc ${SMOUNT}/$i-mount.sh
         echo "-> Mounting $i <-"
         UFS_PATH="/mnt/$i=RW"
         bash ${SMOUNT}/$i-mount.sh
         echo "${UFS_PATH}" >> /tmp/ufstmp.path

done

exit
echo "
UFS_PATH=$(cat /tmp/ufstmp.path)
mount_command='/usr/bin/mergerfs -o sync_read,auto_cache,dropcacheonclose=true,use_ino,allow_other,func.getattr=newest,category.create=ff,minfreespace=0,fsname=mergerfs ${UFS_PATH} /mnt/unionfs'

$mount_command
MERGERFS_PID=$(pgrep mergerfs)

while true; do

  if [ -z ${MERGERFS_PID} ] || [ ! -e /proc/${MERGERFS_PID} ]; then
    $mount_command
    MERGERFS_PID=$(pgrep mergerfs)
  fi
  sleep 10s
done
" 
