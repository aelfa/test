#!/bin/bash
#list_all_folders() {
#tree -d -L 1 /mnt/downloads/torrent/FILME-HD | awk '{print $2}' | tail -n +2 | head -n -2 >/tmp/radarradd
#}

#{
#while read p; do
#/usr/bin/curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "X-Api-Key: $apiKey" -X POST -d '{"title":"'"$title"'","publishDate":"'"$date"'"}' http://radarr:7878/api/release/push
#done </tmp/radarradd
#}
basefolder="/mnt/downloads/torrent/FILME-HD"
radarr_add() {
info=$(cat /opt/appdata/radarr/config.xml)
info=${info#*<ApiKey>} 1>/dev/null 2>&1
apiKeycut=$(echo ${info:0:32}) 1>/dev/null 2>&1
echo $apiKeycut

cd ${basefolder}
 for radarradd in `find . -maxdepth 1 -type d | grep -v "^\.$" `; do
     /usr/bin/curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "X-Api-Key: ${apiKey}" -X POST -d '{"title":"'"$radarradd"'"}' http://radarr:7878/api/release/push
    echo "Movie Add : ${radarradd} successfull"
 done
}

radarr_add
