ARG DOCKER_TAG
FROM fluxter/web-php:${DOCKER_TAG}

RUN apt install -y php${DOCKER_TAG}-xdebug nano iputils-ping

RUN wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O /usr/bin/php-cs-fixer && chmod +x /usr/bin/php-cs-fixer

RUN	chmod +x /scripts/startup/*
ADD	rootfs /