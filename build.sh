function buildTag
{
    docker build ./prod --build-arg DOCKER_TAG=$1 -t fluxter/web-php:$1
    if [ $? != 0 ]; then
        echo Build resulted in an error
    fi

    docker build ./dev --build-arg DOCKER_TAG=$1 -t fluxter/web-php:$1-dev
    if [ $? != 0 ]; then
        echo Build resulted in an error
    fi

    docker push fluxter/web-php:$1
    if [ $? != 0 ]; then
        echo Push resulted in an error
    fi

    docker push fluxter/web-php:$1-dev
    if [ $? != 0 ]; then
        echo Push resulted in an error
    fi
}

buildTag 7.3
buildTag 7.4