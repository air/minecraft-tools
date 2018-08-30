#!/bin/bash

# Download the latest Minecraft client jar and place it where Overviewer needs it.
# requires curl and jq, 'apt-get install curl jq'

# get version metadata
json=$(curl --silent https://launchermeta.mojang.com/mc/game/version_manifest.json)

# filter out snapshots; assume the latest version is at the top
#version=$(echo $json | jq -r '.versions[] | select (.type == "release") | .id' | head -1)
#echo "Latest version: $version"

# Overviewer doesn't support 1.13+ yet, https://github.com/overviewer/Minecraft-Overviewer/issues/1454
version=1.12.2
echo "Forcing version ${version}, Overviewer doesn't support 1.13+ yet."

# select out the packages URL for that version
packages_url=$(echo $json | jq -r ".versions[] | select (.id == \"${version}\") | .url")
echo "Metadata URL: $packages_url"

packages_json=$(curl --silent $packages_url)
client_url=$(echo $packages_json | jq --raw-output .downloads.client.url)
echo "Client jar URL: $client_url"

# download jar straight to where we need it
mkdir -p ~/.minecraft/versions/${version}/
curl -# -f --output ~/.minecraft/versions/${version}/${version}.jar ${client_url}
status=$?
if [ $status -ne 0 ];then
  echo "Error getting the client jar, curl returned: $status"
  exit 1
fi
echo "Downloaded jar to ~/.minecraft/versions/${version}/${version}.jar"
