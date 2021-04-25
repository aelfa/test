#!/usr/bin/with-contenv bash
# shellcheck shell=bash
##################################
# Copyright (c) 2021,  : MrDoob  #
# Docker owner         : doob187 #
# Docker Maintainer    : doob187 #
# Code owner           : doob187 #
#     All rights reserved        #
##################################
# THIS DOCKER IS UNDER LICENSE   #
# NO CUSTOMIZING IS ALLOWED      #
# NO REBRANDING IS ALLOWED       #
# NO CODE MIRRORING IS ALLOWED   #
##################################
# shellcheck disable=SC2086
# shellcheck disable=SC2006

$(command -v docker) system prune -af 1>/dev/null 2>&1
$(command -v docker) pull ghcr.io/doob187/docker-remote:latest 1>/dev/null 2>&1

dockers=$(docker ps -aq --format '{{.Names}}' | sed '/^$/d' | grep -v 'trae' | grep -v 'auth')
for i in ${dockers};do
    $(command -v docker) run --rm -v /opt/appdata:/backup/$i -v /mnt:/mnt ghcr.io/doob187/docker-remote:latest backup $i local
    $(command -v chown) -cR 1000:1000 /opt/appdata/appbackups/local/$i.tar.gz 1>/dev/null 2>&1
done

$(command -v docker) system prune -af 1>/dev/null 2>&1
exit
