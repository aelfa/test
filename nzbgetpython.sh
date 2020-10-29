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
sudo wget -N https://raw.githubusercontent.com/TRaSH-/Guides/master/docs/NZBGet/scripts/WtFnZb-Renamer/WtFnZb-Renamer.py
sudo wget -N https://raw.githubusercontent.com/TRaSH-/Guides/master/docs/NZBGet/scripts/HashRenamer/HashRenamer.py
sudo wget -N https://raw.githubusercontent.com/TRaSH-/Guides/master/docs/NZBGet/scripts/Clean/Clean.py
}

function script_install() {
folder="/opt/appdata/nzbget/scripts/"

if [[ -d $folder ]]; then
sudo rm -rf $folder
sudo mkdir -p $folder
cd $folder
scripts_python3
install_scripts
sudo chown -cR 1000:1000 $folder
sudo chmod -cR 775 $folder
fi
}

function install_scripts() {
sudo docker exec nzbget apk update -q
sudo docker exec nzbget apk add --no-cache python2 -q
sudo docker exec nzbget chown -hR abc:users /config/scripts
sudo docker exec nzbget chmod -R 775 /config/scripts
}

running_check
 
