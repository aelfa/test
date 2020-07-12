#!/bin/bash

if ! docker --version; then
    echo "ERROR: Did Docker get installed?"
    command
else 
    restall 
fi

function reinstall() {
tee <<-EOF
━━━━━━━━━━━━━━━━━━
[Y] UPDATE to lateste version
[Z] Exit
━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  Y) command;;
  y) command ;;
  z) clear && exit ;;
  Z) clear && exit ;;
  *) badinput ;;
  esac
}

function command() {
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

curl https://raw.githubusercontent.com/docker/docker-install/master/install.sh | sudo bash
sudo systemctl enable --now docker
sudo systemctl status docker | awk '$1 == "Active:" {print $2,$3}'

# add current user to docker group so there is no need to use sudo when running docker
sudo usermod -aG docker $(whoami)
sudo id -nG
}
