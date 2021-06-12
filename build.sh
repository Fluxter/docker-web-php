#!/bin/bash
set -e

if [ -z ${1+x} ] || [ -z ${2+x} ]; then 
    echo "Usage:: $0 [PHP Version] [push/build]"
    exit 1
fi

PIPELINE=$((1000 + $GITHUB_RUN_NUMBER))

VERSION=$1
TAG=$1-$PIPELINE
MODE=$2

if [ "${GITHUB_REF}" != "refs/heads/master" ]; then 
    TAG=$TAG-beta
fi

echo "Builiding version $VERSION with tag prefix $TAG and mode $MODE"
if [ "$MODE" = "build" ]; then
    docker build ./prod --build-arg PHP_VERSION=$VERSION -t fluxter/web-php:$TAG
    docker build ./dev --build-arg PHP_VERSION=$VERSION --build-arg BASE_IMG=fluxter/web-php:$TAG -t fluxter/web-php:$TAG-dev --no-cache
elif [ "$MODE" = "push" ]; then
    docker push fluxter/web-php:$TAG
    docker push fluxter/web-php:$TAG-dev
    docker image remove fluxter/web-php:$TAG
    docker image remove fluxter/web-php:$TAG-dev
else
    echo "Unknown mode $MODE. Available: push / build"
    exit 1
fi