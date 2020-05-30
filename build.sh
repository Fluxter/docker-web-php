docker build ./prod --build-arg DOCKER_TAG=7.4 -t fluxter/web-php:7.4
# docker build ./prod --build-arg DOCKER_TAG=7.3 -t fluxter/web-php:7.3
# docker build ./prod --build-arg DOCKER_TAG=7.2 -t fluxter/web-php:7.2

docker build ./dev --build-arg DOCKER_TAG=7.4 -t fluxter/web-php-dev:7.4
# docker build ./dev --build-arg DOCKER_TAG=7.3 -t fluxter/web-php-dev:7.3
# docker build ./dev --build-arg DOCKER_TAG=7.2 -t fluxter/web-php-dev:7.2

docker push fluxter/web-php:7.4
# docker push fluxter/web-php:7.3
# docker push fluxter/web-php:7.2

docker push fluxter/web-php-dev:7.4
# docker push fluxter/web-php-dev:7.3
# docker push fluxter/web-php-dev:7.2