#!/bin/bash
###
### respect goes to spaceman07
###

if [ ! -d "/opt/var/" ]; then
sudo mkdir -p /opt/var
fi 

logfile="/opt/var/plexstats.log"
db="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Plug-in Support/Databases/com.plexapp.plugins.library.db"
echo "$(date "+%d.%m.%Y %T") PLEX LIBRARY STATS" | tee -a $logfile
query="select count(*) from media_items"
result=$(sqlite3 -header -line "$db" "$query")
echo "${result:11} files in library" | tee -a $logfile
query="select count(*) from media_items where bitrate is null"
result=$(sqlite3 -header -line "$db" "$query")
echo "${result:11} files missing analyzation info" | tee -a $logfile

query="SELECT count(*) FROM media_parts WHERE deleted_at is not null"
result=$(sqlite3 -header -line "$db" "$query")
echo "${result:11} media_parts marked as deleted" | tee -a $logfile

query="SELECT count(*) FROM metadata_items WHERE deleted_at is not null"
result=$(sqlite3 -header -line "$db" "$query")
echo "${result:11} metadata_items marked as deleted" | tee -a $logfile

query="SELECT count(*) FROM directories WHERE deleted_at is not null"
result=$(sqlite3 -header -line "$db" "$query")
echo "${result:11} directories marked as deleted" | tee -a $logfile

exit
