#!/bin/bash
# you need httpie and jq (apt-get install httpie jq)

user=$1
password=$2

if [ -z ${user} ] || [ -z ${password} ];then
  echo "Usage: source login.sh <email> <password>"
  echo "You must run using 'source' to export the variables access_token, name and id."
  exit 1
fi

auth_server=https://authserver.mojang.com
client_token=github.com/air/minecraft-tools

response=$(http --check-status --ignore-stdin POST ${auth_server}/authenticate username=${user} password=${password} clientToken=${client_token} agent:='{"name": "Minecraft", "version": 1}')
if [ $? -ne 0 ];then
  echo "Error authenticating, response: ${response}"
  exit 1
fi

# parse details from the JSON response and strip off double quotes
export access_token=$(echo ${response} | jq .accessToken | sed 's/"//g')
export name=$(echo ${response} | jq .selectedProfile.name | sed 's/"//g')
export id=$(echo ${response} | jq .selectedProfile.id | sed 's/"//g')

echo access token: ${access_token}
echo name: ${name}
echo id: ${id}
