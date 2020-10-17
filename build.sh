function buildTag
{
    docker build ./prod --build-arg DOCKER_TAG=$1 -t fluxter/web-php:$1
    docker build ./dev --build-arg DOCKER_TAG=$1 -t fluxter/web-php:$1-dev
    docker push fluxter/web-php:$1
    docker push fluxter/web-php:$1-dev
}

buildTag 7.3
buildTag 7.4