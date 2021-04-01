FROM 		ubuntu:20.04

MAINTAINER  Marcel Kallen, Fluxter <info@fluxter.net>
ENV         DEBIAN_FRONTEND 		noninteractive
ENV			LC_ALL 					C.UTF-8
ARG         DOCKER_TAG

ENV         APP_ROOT "/var/www/html"
ENV         WEBSPACE_ROOT "/var/www/html/public"
ENV         FILE_CRONTAB /crontab

# APT Repositories and Dependencies
RUN apt update && apt upgrade -y
RUN apt install -y unzip mysql-client curl git software-properties-common wget sudo software-properties-common rsync supervisor default-jre cron
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN add-apt-repository ppa:ondrej/php && apt update

# NODE
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# Yarn
RUN apt install -y yarn && yarn --version

# PHP
RUN if [ "$DOCKER_TAG" = "8.0" ]; then apt install -y php8.0-cli php8.0-common php8.0-opcache php8.0-mysql php8.0-mbstring php8.0-zip php8.0-fpm php8.0-tidy php8.0-curl php8.0-xml php8.0-intl; fi
RUN if [ "$DOCKER_TAG" = "7.4" ]; then apt install -y php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-mysql php7.4-mbstring php7.4-zip php7.4-fpm php7.4-tidy php7.4-curl php7.4-xml php7.4-xmlrpc php7.4-intl php7.4-bcmath php7.4-gd; fi
RUN if [ "$DOCKER_TAG" = "7.3" ]; then apt install -y php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-mysql php7.3-mbstring php7.3-zip php7.3-fpm php7.3-tidy php7.3-curl php7.3-xml; fi
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/bin --filename=composer --version=1.10.16 \
    && php -r "unlink('composer-setup.php');"

# NGINX
RUN 	apt install -y nginx
RUN     rm -f /etc/nginx/sites-enabled/*
RUN     mkdir -p /home/www-data/ssl
RUN     chmod -R 777 /var/log/nginx
EXPOSE  80:80

# NODE
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g create-ts-index

# Swagger codegen
RUN wget https://repo1.maven.org/maven2/io/swagger/swagger-codegen-cli/2.4.15/swagger-codegen-cli-2.4.15.jar -O /opt/swagger-codegen-cli.jar \
	&& echo '#!/bin/bash\njava -jar /opt/swagger-codegen-cli.jar $@' > /usr/bin/swagger-codegen \
	&& chmod +x /usr/bin/swagger-codegen
	
# Openapi Codegen
RUN wget https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/5.1.0/openapi-generator-cli-5.1.0.jar -O /opt/openapi-generator.jar \
	&& echo '#!/bin/bash\njava -jar /opt/openapi-generator.jar $@' > /usr/bin/openapi-generator \
	&& chmod +x /usr/bin/openapi-generator

# FILES
ADD	    rootfs /
ADD  	config/php/php-fpm.conf /etc/php/${DOCKER_TAG}/fpm/php-fpm.conf
ADD  	config/php/php.ini /etc/php/${DOCKER_TAG}/fpm/php.ini
ADD  	config/php/php.ini /etc/php/${DOCKER_TAG}/cli/php.ini
ADD  	config/nginx/cache.conf /etc/nginx/conf.d/cache.conf
RUN 	ln -s "/etc/nginx/sites-available/app.conf" "/etc/nginx/sites-enabled/app.conf"
RUN 	ln -s "/etc/nginx/sites-available/app_ssl.conf" "/etc/nginx/sites-enabled/app_ssl.conf"
RUN     chown -R www-data:www-data /home/www-data

# Prepare scripts
RUN     sed -i "s|PHP_VERSION_HERE|${DOCKER_TAG}|g" /etc/nginx/sites-available/app.conf
RUN     sed -i "s|PHP_VERSION_HERE|${DOCKER_TAG}|g" /etc/nginx/sites-available/app_ssl.conf
RUN     sed -i "s|PHP_VERSION_HERE|${DOCKER_TAG}|g" /etc/supervisor/conf.d/php-fpm.conf

# ENVIRONMENT
RUN mkdir -p /var/www
RUN usermod -d /home/www-data --shell /bin/bash www-data
RUN chown -R www-data:www-data /var/www /home/www-data

WORKDIR /var/www/html
ENTRYPOINT ["/scripts/entrypoint.sh"]