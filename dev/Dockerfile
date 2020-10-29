ARG DOCKER_TAG
FROM fluxter/web-php:${DOCKER_TAG}

RUN apt update && \
    apt install -y \
    php${DOCKER_TAG}-xdebug \
    python3-requests python3-requests \
    nano iputils-ping 

RUN wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O /usr/bin/php-cs-fixer && chmod +x /usr/bin/php-cs-fixer

ADD	config/php/21-xdebug.ini /etc/php/${DOCKER_TAG}/fpm/conf.d/21-xdebug.ini
ADD	config/php/21-xdebug.ini /etc/php/${DOCKER_TAG}/cli/conf.d/21-xdebug.ini
ADD	config/nginx/cache.conf /etc/nginx/conf.d/cache.conf