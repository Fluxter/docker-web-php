ARG BASE_IMG
FROM $BASE_IMG
ARG PHP_VERSION

RUN apt update

# Helper
RUN apt install -y nano iputils-ping 

# Python
RUN apt install -y python3-requests python3-requests

# Ant
RUN apt install -y ant

# PHP CS Fixer
RUN wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O /usr/bin/php-cs-fixer && chmod +x /usr/bin/php-cs-fixer



# Tools
RUN sudo -u www-data composer global require fluxter/php-code-helper
RUN sudo -u www-data composer global require fluxter/fxrelease
# RUN echo 'PATH="$PATH:/home/www-data/.composer/vendor/bin"' >> /home/www-data/.bashrc
RUN echo 'PATH="$PATH:/home/www-data/.config/composer/vendor/bin"' >> /home/www-data/.bashrc # Composer 2 puts it here ...

# XDEBUG
RUN apt install -y php${PHP_VERSION}-xdebug 
ADD	config/php/21-xdebug.ini /etc/php/$PHP_VERSION/fpm/conf.d/21-xdebug.ini
ADD	config/php/21-xdebug.ini /etc/php/$PHP_VERSION/cli/conf.d/21-xdebug.ini
ADD	config/nginx/cache.conf /etc/nginx/conf.d/cache.conf