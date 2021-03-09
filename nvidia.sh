#!/usr/bin/with-contenv bash
# shellcheck shell=bash
# Copyright (c) 2020, MrDoob
# All rights reserved

test=$(ls /dev/dri/by-path/ | grep -E "-card" && echo true || echo false)

if [[ $test == "false" ]]; then
    echo " no GPU found"
else
    echo " GPU found"
fi
