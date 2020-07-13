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

# unpack the folder
function run_first() {

AC=find
NM=-name
MD=-maxdepth
EP=-empty
MINAGE='-type f -amin +600'

  $AC $DIR $MD 8 $MINAGE $NM "*.sfv" -exec rm -f \{\} \;
  $AC $DIR $MD 8 $MINAGE $NM "*.txt" -exec rm -f \{\} \;
  $AC $DIR $MD 8 $MINAGE $NM "*.xml" -exec rm -f \{\} \;
  $AC $DIR $MD 8 $MINAGE $NM "Sample" -exec rm -rf {} \;
  $AC $DIR $MD 8 $MINAGE $NM "Proof" -type d -exec rm -rf \{} \;
  $AC $DIR $MD 8 $MINAGE $NM "Screens" -type d -exec rm -rf \{} \;
  $AC $DIR $MD 8 $MINAGE $NM "Cover" -type d -exec rm -rf \{} \;
  $AC $DIR $MD 8 $MINAGE $NM "Subs" -type d -exec rm -rf \{} \;  $AC $DIR $MD 8 $MINAGE $NM "*jpg" -exec rm -f \{\} \;
  $AC $DIR $MD 8 $MINAGE $NM "*jpeg" -exec rm -f \{\} \;
  $AC $DIR $MD 8 $MINAGE $NM "*-sample.mkv" -exec rm -f \{\} \;  $AC $DIR $MD 8 $MINAGE $NM "*sample" -exec rm -rf \{} \;
  $AC $DIR $MD 8 $MINAGE $NM "Screens*" -exec rm -rf \{} \;
  $AC $DIR $MD 8 $MINAGE $NM "Covers*" -exec rm -rf \{} \;
  $AC $DIR $MD 8 $MINAGE $NM "*.nfo" -exec rm -rf \{} \;
  $AC $DIR $MD 8 $MINAGE $NM "Sample*" -exec rm -f \{} \;
  $AC $DIR $MD 8 $MINAGE $NM "*sample*" -exec rm -f \{} \;
  $AC $DIR $MD 8 $MINAGE $NM "*samp*" -exec rm -f \{} \;
  $AC $DIR $MD 8 $MINAGE $NM "*.png" -exec rm -f \{} \;
  $AC $DIR $MD 8 $MINAGE $NM "*.nfo" -type f -exec rm -rf \{} \;
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
