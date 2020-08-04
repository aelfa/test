!/usr/bin/env bash

# Create the environment file for crond
printenv | sed 's/^\([a-zA-Z0-9_]*\)=\(.*\)$/export \1="\2"/g' | grep -E "^export RCLONE" > /cron/rclone.env

RCLONE_CROND_HEALTHCHECK_URL=https://hchk.io/sasa3211-as32-sd32-43ds-sdvbn561cx3456
function check (){
      # Send the payload to the API
      if [[ -z $RCLONE_CROND_HEALTHCHECK_URL ]]; then
         echo "INFO: A health check has not been set. Not using health check services"
      else
         echo "OK: sending message to Healthcheck API..."
         POST=$(curl -s -S "${RCLONE_CROND_HEALTHCHECK_URL}");
         # Check if the message posted to the API. It should return "ok". Anything other than "ok" indicates an issue
         if test "${POST}" != OK; then echo "ERROR: The check to the API failed (${POST})" && return 1; else echo "OK: Message successfully sent to the health check"; fi
      fi
}
check
