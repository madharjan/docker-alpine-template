#!/bin/sh 
set -e

if [ "${DEBUG}" = true ]; then
  set -x
fi

apk update
apk add bash 

cp /build/scripts/docker-entrypoint.sh /
chmod 755 /docker-entrypoint.sh
