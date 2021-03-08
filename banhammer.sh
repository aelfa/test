#!/usr/bin/with-contenv bash
# shellcheck shell=bash
# Copyright (c) 2020, MrDoob
# All rights reserved

network=$(ifconfig | grep -E 'eno1|enp|ens5' | awk '{print $1}' | sed -e 's/://g')

iptables -A INPUT -p tcp --dport 22 -i $network -m state --state NEW -m recent --set
iptables -A INPUT -p tcp --dport 22 -i $network -m state --state ESTABLISHED -m recent --update --seconds 600 --hitcount 2 -j REJECT --reject-with tcp-reset

exit 0
