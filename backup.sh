#!/usr/bin/with-contenv bash
# shellcheck shell=bash
# Copyright (c) 2020, MrDoob
# All rights reserved.
# shellcheck disable=SC2086
# shellcheck disable=SC2006

$(command -v docker) system prune -af 1>/dev/null 2>&1
$(command -v docker) pull ghcr.io/doob187/docker-remote:latest 1>/dev/null 2>&1
$(command -v docker) pull red5d/docker-autocompose 1>/dev/null 2>&1

dockers=$(docker ps -aq --format '{{.Names}}' | sed '/^$/d' | grep -v 'trae' | grep -v 'auth')
for i in ${dockers};do
    $(command -v docker) run --rm -v /var/run/docker.sock:/var/run/docker.sock red5d/docker-autocompose $docker > /opt/appdata/$i/docker-compose.yml
    $(command -v docker) run --rm -v /opt/appdata:/backup/$i -v /mnt:/mnt ghcr.io/doob187/docker-remote:latest backup $i
    $(command -v rm) -rf /opt/appdata/$i/docker-compose.yml 1>/dev/null 2>&1
done

$(command -v docker) system prune -af 1>/dev/null 2>&1
exit
