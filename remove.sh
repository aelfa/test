#!/bin/bash
if pidof -o %PPID -x "$0"; then
    exit 1
fi

############################################
function run_command_1() {
 DIR=/mnt/gdrive/
 run_first
}
function run_command_2() {
 DIR=/mnt/tdrive/
 run_first
}
function run_command_3() {
 DIR=/mnt/tcrypt/
 run_first
}
function run_command_4() {
 DIR=/mnt/gcrypt/
 run_first
}
##############################################################################

## functions part
function run_first() {

AC=find
NM=-name
MD=-maxdepth
EP=-empty

  $AC $DIR $MD 8 $NM "*.sfv" -type f -exec rm -f \{\} \;
  $AC $DIR $MD 8 $NM "*.txt" -type f -exec rm -f \{\} \;
  $AC $DIR $MD 8 $NM "*.xml" -type f -exec rm -f \{\} \;
  $AC $DIR $MD 8 $NM "Sample" -type d -exec rm -rf {} \;
  $AC $DIR $MD 8 $NM "Proof" -type d -exec rm -rf \{} \;
  $AC $DIR $MD 8 $NM "Screens" -type d -exec rm -rf \{} \;
  $AC $DIR $MD 8 $NM "Cover" -type d -exec rm -rf \{} \;
  $AC $DIR $MD 8 $NM "Subs" -type d -exec rm -rf \{} \; 
  $AC $DIR $MD 8 $NM "*jpg" -type f -exec rm -rf \{\} \;
  $AC $DIR $MD 8 $NM "*jpeg" -type f -exec rm -rf \{\} \;
  $AC $DIR $MD 8 $NM "*-sample.mkv" -type f -exec rm -rf \{\} \;  
  $AC $DIR $MD 8 $NM "*sample" -type f -exec rm -rf \{} \;
  $AC $DIR $MD 8 $NM "Screens*" -type d -exec rm -rf \{} \;
  $AC $DIR $MD 8 $NM "Covers*" -type d -exec rm -rf \{} \;
  $AC $DIR $MD 8 $NM "*.nfo" -type f -exec rm -rf \{} \;
  $AC $DIR $MD 8 $NM "Sample*" -type d -exec rm -rf \{} \;
  $AC $DIR $MD 8 $NM "*sample*" -type f -exec rm -rf \{} \;
  $AC $DIR $MD 8 $NM "*samp*" -type f -exec rm -rf \{} \;
  $AC $DIR $MD 8 $NM "*.png" -type f -exec rm -rf \{} \;
  $AC $DIR $MD 8 $NM "*.nfo" -type f -exec rm -rf \{} \;
  $AC $DIR -mindepth 2 -type d $EP -exec rmdir \{} \;

############################################################################
}

##runpart

if [ -d /mnt/gdrive/ ]; then 
    run_command_1
fi
if [ -d /mnt/tdrive/ ]; then
    run_command_2
fi
if [ -d /mnt/tcrypt/ ]; then 
    run_command_3
fi
if [ -d /mnt/gcrypt/ ]; then 
    run_command_4
fi

exit 0
