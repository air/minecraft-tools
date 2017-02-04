#!/bin/bash
# you need httpie (apt-get install httpie)

access_token=$1

if [ -z ${access_token} ];then
  echo 'Usage: validate.sh <access token>'
  exit 1
fi

auth_server=https://authserver.mojang.com
client_token=github.com/air/minecraft-tools

# validate an access token - returns either 204 No Content or 403 Forbidden
http --check-status --ignore-stdin POST ${auth_server}/validate accessToken=${access_token} clientToken=${client_token} >/dev/null 2>&1
case $? in
  0) echo "Token is valid" ;;
  4) echo "Token is invalid, server returned status 403" ;;
  *) echo "Unknown error, httpie exit code: $?" ;;
esac
