ARG DOCKER_TAG
FROM fluxter/web-php:${DOCKER_TAG}

RUN apt update

# Helper
RUN apt install -y nano iputils-ping 

# Python
RUN apt install -y python3-requests python3-requests

# Ant
RUN apt install -y ant

# PHP CS Fixer
RUN wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O /usr/bin/php-cs-fixer && chmod +x /usr/bin/php-cs-fixer

# XDEBUG
RUN apt install -y php${DOCKER_TAG}-xdebug 
ADD	config/php/21-xdebug.ini /etc/php/${DOCKER_TAG}/fpm/conf.d/21-xdebug.ini
ADD	config/php/21-xdebug.ini /etc/php/${DOCKER_TAG}/cli/conf.d/21-xdebug.ini
ADD	config/nginx/cache.conf /etc/nginx/conf.d/cache.conf