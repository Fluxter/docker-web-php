#!/bin/bash
set -e

if [ -z ${1+x} ] || [ -z ${2+x} ]; then 
    echo "Usage:: $0 [PHP Version] [push/build]"
    exit 1
fi

VERSION=$1
TAG=$1
MODE=$2

if [ "${CI_COMMIT_BRANCH}" != "master" ]; then 
    TAG=$TAG-beta
fi

echo "Builiding version $VERSION with tag prefix $TAG and mode $MODE"
if [ "$MODE" = "build" ]; then 
    docker build ./prod --build-arg DOCKER_TAG=$VERSION -t fluxter/web-php:$TAG
    docker build ./dev --build-arg DOCKER_TAG=$VERSION -t fluxter/web-php:$TAG-dev
elif [ "$MODE" = "push" ]; then 
    docker push fluxter/web-php:$TAG
    docker push fluxter/web-php:$TAG-dev
    docker image remove fluxter/web-php:$TAG
    docker image remove fluxter/web-php:$TAG-dev
else
    echo "Unknown mode $MODE. Available: push / build"
    exit 1
fi