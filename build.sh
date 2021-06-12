#!/bin/bash
set -e

if [ -z ${1+x} ] || [ -z ${2+x} ]; then 
    echo "Usage:: $0 [PHP Version] [push/build]"
    exit 1
fi

PHP_VERSION=$1
MODE=$2

CONTAINER_VERSION=`cat version.txt`
BUILD=$((1000 + $GITHUB_RUN_NUMBER))
TAG=v${CONTAINER_VERSION}-php${PHP_VERSION}

if [ "$MODE" = "build" ]; then
    echo "----"
    echo "Builiding version $PHP_VERSION with tag prefix $TAG and mode $MODE"
    echo "----"
    BUILD_CMD_PROD="docker build ./prod --build-arg PHP_VERSION=$PHP_VERSION --no-cache"
    BUILD_CMD_DEV="docker build ./dev --build-arg PHP_VERSION=$PHP_VERSION --build-arg BASE_IMG=fluxter/web-php:$TAG-prod-b${BUILD} --no-cache"
    if [ "${GITHUB_REF}" = "refs/heads/master" ]; then 
        $BUILD_CMD_PROD -t fluxter/web-php:$TAG-prod-latest fluxter/web-php:$TAG-prod-b${BUILD}
        $BUILD_CMD_DEV -t fluxter/web-php:$TAG-dev-latest fluxter/web-php:$TAG-dev-b${BUILD}
    else
        $BUILD_CMD_PROD -t fluxter/web-php:$TAG-prod-b${BUILD}
        $BUILD_CMD_DEV -t fluxter/web-php:$TAG-dev-b${BUILD}
    fi
elif [ "$MODE" = "push" ]; then
    echo "Pushing version $PHP_VERSION with tag prefix $TAG and mode $MODE"
    docker push fluxter/web-php:$TAG
    docker push fluxter/web-php:$TAG-dev
    docker image remove fluxter/web-php:$TAG
    docker image remove fluxter/web-php:$TAG-dev
else
    echo "Unknown mode $MODE. Available: push / build"
    exit 1
fi