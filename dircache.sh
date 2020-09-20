#!/bin/bash

if pidof -o %PPID -x "$0"; then
    exit 1
else
   ls -alR /mnt/unionfs | grep -v 'encrypt'
fi
exit 1 
