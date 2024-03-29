FROM 		ubuntu:20.04

MAINTAINER  Marcel Kallen, Fluxter <info@fluxter.net>
ENV         DEBIAN_FRONTEND 		noninteractive
ENV			LC_ALL 					C.UTF-8
ARG         PHP_VERSION

ENV         APP_ROOT "/var/www/html"
ENV         FILE_UPLOAD_LIMIT "2M"

# APT Repositories and Dependencies
RUN apt update && apt upgrade -y
RUN apt install -y unzip mysql-client curl git software-properties-common wget sudo software-properties-common rsync supervisor default-jre cron nano iputils-ping make g++
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN add-apt-repository ppa:ondrej/php && apt update

# NODE
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g create-ts-index

# Yarn
RUN apt install -y yarn && yarn --version

# PHP
RUN if [ "$PHP_VERSION" = "8.1" ]; then apt install -y php8.1-cli php8.1-common php8.1-opcache php8.1-mysql php8.1-mbstring php8.1-zip php8.1-fpm php8.1-tidy php8.1-curl php8.1-xml php8.1-intl php8.1-gd; fi
RUN if [ "$PHP_VERSION" = "8.0" ]; then apt install -y php8.0-cli php8.0-common php8.0-opcache php8.0-mysql php8.0-mbstring php8.0-zip php8.0-fpm php8.0-tidy php8.0-curl php8.0-xml php8.0-intl php8.0-gd; fi
RUN if [ "$PHP_VERSION" = "7.4" ]; then apt install -y php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-mysql php7.4-mbstring php7.4-zip php7.4-fpm php7.4-tidy php7.4-curl php7.4-xml php7.4-xmlrpc php7.4-intl php7.4-bcmath php7.4-gd; fi
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/bin --filename=composer --2 \
    && php -r "unlink('composer-setup.php');"
RUN chown -R www-data:www-data /var/lib/php/sessions


# NGINX
RUN 	apt install -y nginx
RUN     rm -f /etc/nginx/sites-enabled/*
RUN     mkdir -p /home/www-data/ssl
RUN     chmod -R 777 /var/log/nginx
EXPOSE  80:80
	
# Openapi Codegen
# Version 5.0.0-beta3 is the latest version
# See following issue https://github.com/OpenAPITools/openapi-generator/issues/9146
RUN wget https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/5.0.0-beta3/openapi-generator-cli-5.0.0-beta3.jar -O /opt/openapi-generator-5.0.0-beta3.jar \
	&& echo '#!/bin/bash\njava -jar /opt/openapi-generator-5.0.0-beta3.jar $@' > /usr/bin/openapi-generator-5.0.0-beta3 \
	&& chmod +x /usr/bin/openapi-generator-5.0.0-beta3
RUN wget https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/5.4.0/openapi-generator-cli-5.4.0.jar -O /opt/openapi-generator.jar \
	&& echo '#!/bin/bash\njava -jar /opt/openapi-generator.jar $@' > /usr/bin/openapi-generator \
	&& chmod +x /usr/bin/openapi-generator

# FILES
ADD	    rootfs /
ADD  	config/php/php-fpm.conf /etc/php/${PHP_VERSION}/fpm/php-fpm.conf
ADD  	config/php/php.ini /etc/php/${PHP_VERSION}/fpm/php.ini
ADD  	config/php/php.ini /etc/php/${PHP_VERSION}/cli/php.ini
ADD  	config/nginx/cache.conf /etc/nginx/conf.d/cache.conf
RUN 	ln -s "/etc/nginx/sites-available/app.conf" "/etc/nginx/sites-enabled/app.conf"
RUN 	ln -s "/etc/nginx/sites-available/app_ssl.conf" "/etc/nginx/sites-enabled/app_ssl.conf"
RUN     chown -R www-data:www-data /home/www-data

# Prepare scripts
RUN     sed -i "s|PHP_VERSION_HERE|${PHP_VERSION}|g" /etc/nginx/sites-available/app.conf
RUN     sed -i "s|PHP_VERSION_HERE|${PHP_VERSION}|g" /etc/nginx/sites-available/app_ssl.conf
RUN     sed -i "s|PHP_VERSION_HERE|${PHP_VERSION}|g" /etc/supervisor/conf.d/php-fpm.conf
RUN     sed -i "s|PHP_VERSION_HERE|${PHP_VERSION}|g" /scripts/environment.sh

# ENVIRONMENT
RUN mkdir -p /var/www
RUN usermod -d /home/www-data --shell /bin/bash www-data
RUN chown -R www-data:www-data /var/www /home/www-data
RUN echo source /scripts/environment.sh >> /etc/bash.bashrc

WORKDIR /var/www/html
ENTRYPOINT ["/scripts/entrypoint.sh"]