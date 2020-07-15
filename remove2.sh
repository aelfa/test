#!/bin/bash
if pidof -o %PPID -x "$0"; then
    exit 1
fi

# basic settings
TARGET_FOLDER="/mnt/{gdrive,tdrive,gcrypt,tcrypt}/"
# find files in this folders

# advanced settings
FIND=$(which find)
FIND_BASE_CONDITION_UNWANTED='-type f'
FIND_ADD_NAME='-o -iname'
FIND_DEL_NAME='! -iname'
FIND_ACTION='-not -path "*encrypt*" -delete > /dev/null 2>&1'

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
condition="-iname '${UNWANTED_FILES[0]}'"
for ((i = 1; i < ${#UNWANTED_FILES[@]}; i++))
do
    condition="${condition} ${FIND_ADD_NAME} '${UNWANTED_FILES[i]}'"
done
command="${FIND} ${TARGET_FOLDER} -mindepth 1 ${FIND_BASE_CONDITION_UNWANTED} \( ${condition} \) ${FIND_ACTION}"
echo "Executing ${command}"
eval "${command}"

command="${FIND} ${TARGET_FOLDER} -mindepth 1 -type d -empty ${FIND_ACTION}"
echo "Executing ${command}"
eval "${command}"
