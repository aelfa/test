#!/usr/bin/env bash
# cleanremotes accepts a command line filter now.  e.g. `./cleanremotes tv` will
# only clean remotes that have `tv` in them

filter="$1"
config=/config/rclone.conf
#rclone listremotes | gawk "$filter"
mapfile -t file < <(eval rclone listremotes --config=${config} | grep "$filter" | sed -e 's/[GDSA[00-99C:]//g' | sed '/^$/d')

for i in ${file[@]}; do
  echo; echo STARTING DEDUPE of identical files from $i; echo
  rclone dedupe skip $i -v --config=${config} --drive-use-trash=false --no-traverse --transfers=50
  echo; echo REMOVING EMPTY DIRECTORIES from $i; echo
  rclone rmdirs $i -v --config=${config} --drive-use-trash=false --fast-list --transfers=50
  echo; echo PERMANENTLY DELETING TRASH from $i; echo
  rclone delete $i --config=${config} --fast-list --drive-trashed-only --drive-use-trash=false -v --transfers 50
  rclone cleanup $i -v --config=${config}
done
