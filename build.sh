docker build ./prod --build-arg DOCKER_TAG=7.4 -t fluxter/web-php:7.4
docker build ./prod --build-arg DOCKER_TAG=7.3 -t fluxter/web-php:7.3

docker build ./dev --build-arg DOCKER_TAG=7.4 -t fluxter/web-php:7.4-dev
docker build ./dev --build-arg DOCKER_TAG=7.3 -t fluxter/web-php:7.3-dev

docker push fluxter/web-php:7.3
docker push fluxter/web-php:7.4

docker push fluxter/web-php:7.3-dev
docker push fluxter/web-php:7.4-dev