#!/bin/bash

# Download the latest Minecraft client jar and place it where Overviewer needs it.
# requires curl and jq, 'apt-get install curl jq'

# get version metadata
json=$(curl --silent https://launchermeta.mojang.com/mc/game/version_manifest.json)

# filter out snapshots; assume the latest version is at the top
version=$(echo $json | jq -r '.versions[] | select (.type == "release") | .id' | head -1)

# download jar straight to where we need it
download_host=https://s3.amazonaws.com/Minecraft.Download/versions
mkdir -p ~/.minecraft/versions/${version}/
curl -# -f --output ~/.minecraft/versions/${version}/${version}.jar ${download_host}/${version}/${version}.jar
status=$?
if [ $status -ne 0 ];then
  echo "Error getting the client jar, curl returned: $status"
  exit 1
fi
echo "Downloaded jar to ~/.minecraft/versions/${version}/${version}.jar"
