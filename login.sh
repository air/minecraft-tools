#!/bin/bash
# you need httpie and jq (apt-get install httpie jq)

if [ "${BASH_SOURCE}" == "${0}" ];then
  echo "Exiting - you should run this script using 'source' to export your access token and ID."
  exit
fi

user=$1
password=$2

if [ -z ${user} ] || [ -z ${password} ];then
  echo "Usage: source login.sh <email> <password>"
else
  auth_server=https://authserver.mojang.com
  client_token=github.com/air/minecraft-tools

  response=$(http --check-status --ignore-stdin POST ${auth_server}/authenticate username=${user} password=${password} clientToken=${client_token} agent:='{"name": "Minecraft", "version": 1}')
  if [ $? -ne 0 ];then
    echo "Error authenticating, response: ${response}"
    return 1
  fi

  # parse details from the JSON response and strip off double quotes
  export access_token=$(echo ${response} | jq .accessToken | sed 's/"//g')
  export name=$(echo ${response} | jq .selectedProfile.name | sed 's/"//g')
  export id=$(echo ${response} | jq .selectedProfile.id | sed 's/"//g')

  echo access token: ${access_token}
  echo name: ${name}
  echo id: ${id}
fi
