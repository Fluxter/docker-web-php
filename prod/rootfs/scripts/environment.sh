#!/bin/bash

echo "Setting up environment"

export DOCKER_HOST_IP=`ip -4 route list match 0/0 | awk '{print $3}'`

if [ -z ${WEBSPACE_ROOT+x} ]; then
    export WEBSPACE_ROOT="$APP_ROOT/public"
fi
if [ -z ${FILE_CRONTAB+x} ]; then
    export FILE_CRONTAB="$APP_ROOT/crontab"
fi
if [ -z ${SYMFONY_CONSOLE+x} ]; then
    export SYMFONY_CONSOLE="$APP_ROOT/bin/console"
fi
if [ -z ${FILE_PARAMETERS+x} ]; then
    export FILE_PARAMETERS="$APP_ROOT/.env.local"
fi
if [ -z ${FILE_PARAMETERS_DIST+x} ]; then
    export FILE_PARAMETERS_DIST="$FILE_PARAMETERS.dist"
fi

export SC=$SYMFONY_CONSOLE
export PHP_VERSION=PHP_VERSION_HERE