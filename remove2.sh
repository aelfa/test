#!/bin/bash

UNWANTED_FILES=(
    '*.nfo'
    '*.jpeg'
    '*.jpg'
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
    '*.pdf'
    '*.xml'
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
    )
# advanced settings
FIND=$(which find)
FIND_BASE_CONDITION='-type f'
FIND_ADD_NAME='-o -name'
FIND_ACTION='-not -path "*encrypt*" -delete > /dev/null 2>&1'

#Folder Setting
TARGET_FOLDER=$1"/mnt/{gdrive,tdrive,gcrypt,tcrypt}/"

if [ ! -d "${TARGET_FOLDER}" ]; then echo 'Target directory does not exist - skipping '; fi
    condition="-name '${UNWANTED_FILES[0]}'"
for ((i = 1; i < ${#UNWANTED_FILES[@]}; i++))
do
  condition="${condition} ${FIND_ADD_NAME} '${UNWANTED_FILES[i]}'"
done

command="${FIND} '${TARGET_FOLDER}' -mindepth 2 ${FIND_BASE_CONDITION} \( ${condition} \) ${FIND_ACTION}"
echo "Executing ${command}"
eval "${command}"

command="${FIND} ${TARGET_FOLDER} -mindepth 2 -type d -empty ${FIND_ACTION}"
#echo "Executing ${command}"
eval "${command}"
exit 0
