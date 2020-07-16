#!/bin/bash
if pidof -o %PPID -x "$0"; then
    exit 1
fi

TESTPART="$@"
##########
if [ ${TESTPART} == "help" ]; then
clear 
 printf '
┌──────────────────────────┐
│-== Remove Garbage files via rclone ==-  │
│_________________________________________│
│ commands                                │
│ print help part                help     │
│ add drive:/folder                       │ 
└──────────────────────────┘
'
exit 1
else
#########################
FIND=$(which rclone)
FIND_ADD_NAME='--include'
FIND_DEL_NAME='delete -v --no-traverse'
FIND_DEL_EMPTY='--rmdirs'
CONFIG='--config'
CONFIG_FILE='/opt/appdata/plexguide/rclone.conf'
#########################
UNWANTED_FILES=(
    '*.nfo'
    '*.jpeg'
    '*.jpg'
    '*.gif'
    '*.rar'
    '*sample*'
    '*.1'
    '*.2'
    '*.3'
    '*.4'
    '*.5'
    '*.6'
    '*.7'
    '*.8'
    '*.9'
    '*.10'
    '*.11'
    '*.12'
    '*.13'
    '*.14'
    '*.15'
    '*.16'
    '*.html~'
    '*.url'
    '*.htm'
    '*.html'
    '*.sfv'
    '*sample.*'
    '*.sh'
    '*.pdf'
    '*.doc'
    '*.docx'
    '*.xls'
    '*.xlsx'
    '*.xml'
    '*.html'
    '*.htm'
    '*.exe'
    '*.lsn'
    '*.nzb'
    'Click.rar'
    'What.rar'
    '*sample*'
    '*SAMPLE*'
    '*SaMpLE*'
    '*.nfo'
    '*.jpeg'
    '*.jpg'
    '*.srt'
    '*.idx'
    '*.rar'
    '*sample*'
    '*.png*'
)

#Folder Setting
condition="--include '${UNWANTED_FILES[0]}'"
for ((i = 1; i < ${#UNWANTED_FILES[@]}; i++))
do
    condition="${condition} ${FIND_ADD_NAME} ${UNWANTED_FILES[i]}"
done

echo "rclone delete start for ${TESTPART}"
${FIND} ${FIND_DEL_NAME} ${TESTPART} "${condition}" ${CONFIG}=${CONFIG_FILE}
fi
echo "rclone delete finished for ${TESTPART}"
exit 1
