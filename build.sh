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

    if [ "$2" == "push" ]; then
        docker push fluxter/web-php:$1
        if [ $? != 0 ]; then
            echo Push resulted in an error
        fi

        docker push fluxter/web-php:$1-dev
        if [ $? != 0 ]; then
            echo Push resulted in an error
        fi
    else
        echo "Not pushing, run command with push like this: $0 push"
    fi
}

buildTag 7.3 $1
buildTag 7.4 $1
buildTag 8.0 $1