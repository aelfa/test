#!/bin/bash

if pidof -o %PPID -x "$0"; then
    exit 1
else
   ls -alR /mnt/unionfs
fi
exit 1 
