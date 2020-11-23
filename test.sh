#!/bin/bash
display_result() {
  dialog --title "$1" \
    --no-collapse \
    --msgbox "$result" 0 0
}
display_user() {
  dialog --title "$1" \
  --inputbox 16 51 2> $tmp_file_user
}
display_password() {
  dialog --title "$1" \
   --no-collapse \
   --passwordbox 16 51 2> $tmp_file_password
}
create_user() {
  tmp_file_user=$(tempfile 2>/dev/null) || tmp_file_user=/tmp/test$$
  tmp_file_password=$(tempfile 2>/dev/null) || tmp_file_password=/tmp/test$$
  username=$(cat $tmp_file_user)
  pass=$(cat $tmp_file_password)
  pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
  useradd -m -p $pass $username
  usermod -aG sudo $username
  sudo usermod -s /bin/bash $username
  usermod -aG video $username
  usermod -aG docker $username
  trap "rm -f $tmp_file_user" 0 1 2 5 15
  trap "rm -f $tmp_file_password" 0 1 2 5 15
}

display_exist() {
    dialog --title "$1" \
    --no-collapse \
    --msgbox "$result" 0 0
} 
while true; do
  exec 3>&1
  selection=$(dialog \
    --backtitle "Sudobox.Io Install Interface" \
    --title "Menu" \
    --clear \
    --cancel-label "Exit" \
    --menu "Please select:" $HEIGHT $WIDTH 4 \
    "1" "Create a sudo user" \
    "2" "Use existing sudo user" \
    "3" "Install Sudobox.io now" \
    2>&1 1>&3)
  exit_status=$?
  exec 3>&-
  case $exit_status in
    $DIALOG_CANCEL)
      clear && echo "Program terminated." 
      exit ;;
    $DIALOG_ESC)
      clear && echo "Program aborted." >&2
      exit 1
      ;;
  esac
  case $selection in
    0 )
      clear && echo "Program terminated."
      ;;
    1 )
      display_user "Create sudo user"
      display_password "Typ password" 
      create_user && clear
      ;;
    2 )
      display_exist "Use existing sudo User"
      usermod -aG sudo $(grep "1000" /etc/passwd | cut -d: -f1 | awk '{print $1}')
      sudo usermod -s /bin/bash $(grep "1000" /etc/passwd | cut -d: -f1 | awk '{print $1}')
      sudo usermod -aG video $(grep "1000" /etc/passwd | cut -d: -f1 | awk '{print $1}')
      sudo usermod -aG docker $(grep "1000" /etc/passwd | cut -d: -f1 | awk '{print $1}')
      result=$(echo "All done")
      ;;
    3 )
      ## run the rest after here 
      clear
      ;;
  esac
done
