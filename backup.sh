#!/usr/bin/with-contenv bash
# shellcheck shell=bash
# Copyright (c) 2020, MrDoob
# All rights reserved.
# shellcheck disable=SC2086
# shellcheck disable=SC2006

dockers=$(docker ps -aq --format '{{.Names}}' | sed '/^$/d')
for i in ${dockers};do
    $(command -v docker) run --rm -v /opt/appdata:/backup/$i -v /mnt:/mnt ghcr.io/doob187/docker-remote:latest backup $i
done

$(command -v docker) system prune -af

exit
