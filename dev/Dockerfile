FROM fluxter/symfony-web:7.4

RUN apt install -y php7.4-xdebug nano iputils-ping

RUN wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O /usr/bin/php-cs-fixer && chmod +x /usr/bin/php-cs-fixer

RUN	chmod +x /scripts/startup/*
ADD	rootfs /