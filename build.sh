#!/bin/bash
set -e

if [ -z ${1+x} ] || [ -z ${2+x} ]; then 
    echo "Usage:: $0 [PHP Version] [push/build]"
    exit 1
fi

if [ -z ${GITHUB_RUN_NUMBER+x} ]; then 
    echo "If this script is beeing executed outside of docker actions, please add the env var GITHUB_RUN_NUMBER"
    echo "e.g. \"export GITHUB_RUN_NUMBER=1\""
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
        $BUILD_CMD_PROD -t fluxter/web-php:$TAG-prod-latest -t fluxter/web-php:$TAG-prod-b${BUILD}
        $BUILD_CMD_DEV -t fluxter/web-php:$TAG-dev-latest -t fluxter/web-php:$TAG-dev-b${BUILD}
    else
        $BUILD_CMD_PROD -t fluxter/web-php:$TAG-prod-b${BUILD}-beta
        $BUILD_CMD_DEV -t fluxter/web-php:$TAG-dev-b${BUILD}-beta
    fi
elif [ "$MODE" = "push" ]; then
    echo "Pushing version $PHP_VERSION with tag prefix $TAG and mode $MODE"
    
    if [ "${GITHUB_REF}" = "refs/heads/master" ]; then 
        docker push fluxter/web-php:$TAG-prod-latest
        docker push fluxter/web-php:$TAG-dev-latest
        docker push fluxter/web-php:$TAG-prod-b${BUILD}
        docker push fluxter/web-php:$TAG-dev-b${BUILD}
    else
        docker push fluxter/web-php:$TAG-prod-b${BUILD}-beta
        docker push fluxter/web-php:$TAG-dev-b${BUILD}-beta
    fi

else
    echo "Unknown mode $MODE. Available: push / build"
    exit 1
fi