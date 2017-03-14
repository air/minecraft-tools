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
curl --output ~/.minecraft/versions/${version}/${version}.jar ${download_host}/${version}/${version}.jar
