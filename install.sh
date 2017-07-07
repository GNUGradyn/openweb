#!/bin/bash
if [[ "$(whoami)" != "root" ]]; then
	echo "Run as root."
	exit 1
fi
set -e
set -o pipefail
read -p "Enter private url: " privateurl
echo "Storing current /etc/hosts for use when updating hosts..."
sudo cp /etc/hosts /etc/hosts.d
echo "installing update script..."
echo "set -e" > update
echo "set -o pipefail" >> update
echo "echo updating..." >> update
echo "rm -r /etc/hosts" >> update
echo "cp /etc/hosts.d /etc/hosts" >> update
echo "curl $privateurl | sudo tee --append /etc/hosts" >> update
sudo mv update /usr/bin/update-openweb
sudo chmod +x /usr/bin/update-openweb
echo "running first time update..."
sudo update-openweb
echo "Done!"
exit 0
