#!/bin/bash

if [ -z "$DIR_APP" ]; then
    export DIR_APP=/app 
fi
if [ -z "$FILE_CRONTAB" ]; then
    export FILE_CRONTAB=/app/crontab
fi
if [ -n "$USER_ID" ] && [ -n "$GROUP_ID" ]; then
    echo "Found User ID: $USER_ID"
    echo "Found GROUP ID: $GROUP_ID"
    echo "Setting permissions..."
    export USER_NAME=www-data
    export HOME=/home/www-data
else
    echo "The ENV variables USER_ID and/or GROUP_ID havent been set!"
    export USER_NAME=root
    export USER_ID=0
    export GROUP_ID=0
fi

export FILE_PARAMETERS_DIST=$DIR_APP/.env.local.dist
export FILE_PARAMETERS=$DIR_APP/.env.local

export DOCKER_HOST_IP=`ip -4 route list match 0/0 | awk '{print $3}'`