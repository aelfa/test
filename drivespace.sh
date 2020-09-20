#!/usr/bin/with-contenv bash
# shellcheck shell=bash
drivespace=$(df -Bg / --local | tail -n +2 | awk '{print $4}' | sed -e 's/G//g')
if [[ "$drivespace" -le "40" ]]; then
  echo "less then 40GB "
elif [[ "$drivespace" -le "80" && "$drivespace" -gt "40" ]]; then
  echo "less then 80GB but greater as 40GB"
elif [[ "$drivespace" -le "120" && "$drivespace" -gt "80" ]]; then
  echo "less then 120GB but greater as 80GB"
elif [[ "$drivespace" -le "200" && "$drivespace" -gt "120" ]]; then
  echo "less then 200GB but greater as 120GB"
else
  echo "greater as 200GB free space"
fi
