#!/bin/bash
#
# Title:            Sabnzbd fix
# Author(s):        mrdoob
# Code inspiration: Krallenkiller
# URL:              https://sudobox.io/
# GNU:              General Public License v3.0
################################################################################
package_list="update upgrade dist-upgrade autoremove autoclean"
for i in ${package_list}; do
    echo "apt $i is running"
    apt $i -yqq 1>/dev/null 2>&1
done
sleep 1
sabnzbd=$(docker ps -aq --format={{.Names}} | grep -qE 'sabnzbd' && echo true || echo false)
if [[ $sabnzbd  == "true" ]]; then
   for i in ${package_list}; do
       echo "apt $i for sabnzbd is running"
       docker exec sabnzbd apt $i -yqq 1>/dev/null 2>&1
   done
   docker restart sabnzbd 1>/dev/null 2>&1
   echo "sabnzbd  restarted" 
fi

echo "all done"
