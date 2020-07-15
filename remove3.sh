#!/bin/bash
if pidof -o %PPID -x "$0"; then
    exit 1
fi

FIND=$(which rclone)
FIND_ADD_NAME='--include'
FIND_DEL_NAME='delete'
FIND_DEL_EMPTY='--rmdirs'
CONFIG='--config'
CONFIG_FILE='/opt/appdata/plexguide/rclone.conf'

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

#if grep -q gcrypt ${CONFIG_FILE}; then
#   ${FIND} ${FIND_DEL_NAME} gcrypt: ${FIND_ADD_NAME}=${UNWANTED_FILES} ${CONFIG}=${CONFIG_FILE}
#fi

#if grep -q gdrive ${CONFIG_FILE}; then
#   ${FIND} ${FIND_DEL_NAME} gdrive: ${FIND_ADD_NAME}=${UNWANTED_FILES} ${CONFIG}=${CONFIG_FILE}
#fi

#if grep -q tcrypt ${CONFIG_FILE}; then
#   ${FIND} ${FIND_DEL_NAME} tcrypt: ${FIND_ADD_NAME}=${UNWANTED_FILES} ${CONFIG}=${CONFIG_FILE}
#fi

#if grep -q tdrive ${CONFIG_FILE}; then
#   ${FIND} ${FIND_DEL_NAME} tdrive: ${FIND_ADD_NAME}=${UNWANTED_FILES} ${CONFIG}=${CONFIG_FILE}
#fi

${FIND} --dry-run ${FIND_DEL_NAME} gcrypt: ${FIND_ADD_NAME}=${UNWANTED_FILES} ${CONFIG}=${CONFIG_FILE}
