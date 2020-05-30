FROM 		ubuntu:18.04


MAINTAINER  Marcel Kallen, Fluxter <info@fluxter.net>
ENV         DEBIAN_FRONTEND 		noninteractive
ENV			LC_ALL 					C.UTF-8
ARG         DOCKER_TAG

# Dependencies
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y unzip mysql-client curl npm git software-properties-common wget sudo software-properties-common

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install -y yarn && yarn --version

# PHP
RUN add-apt-repository ppa:ondrej/php && apt-get update
RUN if [ "$DOCKER_TAG" = "7.4" ] ; then apt install -y php7.4-cli php7.4-common php7.4-json php7.4-opcach php7.4-mysql php7.4-mbstring php7.4-zip php7.4-fpm php7.4-tidy php7.4-curl php7.4-xml php7.4-xmlrpc php7.4-intl
RUN if [ "$DOCKER_TAG" = "7.3" ] ; then apt install -y php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-mysql php7.3-mbstring php7.3-zip php7.3-fpm php7.3-tidy php7.3-curl php7.3-xml
RUN if [ "$DOCKER_TAG" = "7.2" ] ; then apt install -y php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-mysql php7.2-mbstring php7.2-zip php7.2-fpm php7.2-tidy php7.2-curl php7.2-xml php7.2-xmlrpc php7.2-intl
RUN curl -s https://getcomposer.org/installer | php

# NGINX
RUN 	apt-get install -y nginx
RUN     rm -f /etc/nginx/nginx.conf
RUN     rm -f /etc/nginx/sites-enabled/*
EXPOSE  80:80
RUN		mkdir -p /app/
RUN 	ln -s "/etc/nginx/sites-available/app.conf" "/etc/nginx/sites-enabled/app.conf"

# DYNAMIC USERNAME
RUN 	echo "if [ \${USER_ID:-0} -ne 0 ] && [ \${GROUP_ID:-0} -ne 0 ]; then" >> ~/.bashrc && \
        echo "username=\$(id -nu \$USER_ID)" >> ~/.bashrc && \
        echo "cd $DIR_APP" >> ~/.bashrc && \
        echo "echo \"You are now logged in as \$username in folder \$DIR_APP\"" >> ~/.bashrc && \
        echo "su - \$username" >> ~/.bashrc && \
		echo "fi" >> ~/.bashrc

ADD		rootfs /

# Prepare scripts
RUN   sed -i "s|PHP_VERSION_HERE|${DOCKER_TAG}|g" /etc/nginx/sites-available/app.conf
RUN   sed -i "s|PHP_VERSION_HERE|${DOCKER_TAG}|g" /scripts/startup/80-startphp
RUN cat /scripts/startup/80-startphp

RUN chmod +x /scripts/entrypoint.sh
RUN	chmod +x /scripts/startup/*


WORKDIR /app
ENTRYPOINT ["/scripts/entrypoint.sh"]