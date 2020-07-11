#!/bin/bash 
running_check() {
  nzbget=$(docker ps --format '{{.Names}}' | grep "nzbget")
  if [[ "$nzbget" == "nzbget" ]]; then
  script_install
  fi
}

function scripts_python3() {
sudo wget -N https://raw.githubusercontent.com/h1f0x/nzbget-python3-scripts/master/python3/DeleteSamples.py
sudo wget -N https://raw.githubusercontent.com/h1f0x/nzbget-python3-scripts/master/python3/FakeDetector.py
sudo wget -N https://raw.githubusercontent.com/h1f0x/nzbget-python3-scripts/master/python3/GetPw.py
sudo wget -N https://raw.githubusercontent.com/h1f0x/nzbget-python3-scripts/master/python3/SafeRename.py
sudo wget -N https://raw.githubusercontent.com/h1f0x/nzbget-python3-scripts/master/python3/TidyIt.py
sudo wget -N https://raw.githubusercontent.com/h1f0x/nzbget-python3-scripts/master/python3/flatten-dirs.py
sudo wget -N https://raw.githubusercontent.com/h1f0x/nzbget-python3-scripts/master/python3/reverse-name.py
sudo wget -N https://raw.githubusercontent.com/h1f0x/nzbget-python3-scripts/master/python3/unzip.py
}

function script_install() {
nzbgetscriptfolder="/opt/appdata/nzbget/scripts"

if [[ -d "$nzbgetsciptfolder" ]]; then
#rm -rf "$nzbgetscriptfolder"
cd "$nzbgetscriptfolder" 
scripts_python3
install_scripts
fi
}

function install_scripts() {
sudo docker exec nzbget apk update -q
sudo docker exec nzbget apk add --no-cache python2 -q
sudo docker exec nzbget chown -hR abc:users /config/scripts
sudo docker exec nzbget chmod -R 775 /config/scripts
}

running_check
 
