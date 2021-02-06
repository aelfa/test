#!/usr/bin/with-contenv bash
# shellcheck shell=bash
# Copyright (c) 2020, MrDoob
# All rights reserved.

### $1 > Traktarr or Traktarr4k ( name of the docker )
### $2 > movies or shows 
### $3 > https lists or trakt.tv popular or box-office 

IFS=$'\n'
list=/home/trakt/trakt.list
mapfile -t traktlist < <(eval cat ${list})
##### RUN Traktarr #####
for i in ${traktlist[@]}; do
   PROG=$1
   ART=$2
   LIST=$3
   #docker exec "${PROG}" traktarr "${ART}" -t "${LIST}" 1>/dev/null 2>&1
   echo "$i"
done
exit
