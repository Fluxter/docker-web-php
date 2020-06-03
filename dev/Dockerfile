ARG DOCKER_TAG
FROM fluxter/web-php:${DOCKER_TAG}

RUN apt install -y php${DOCKER_TAG}-xdebug nano iputils-ping

RUN wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O /usr/bin/php-cs-fixer && chmod +x /usr/bin/php-cs-fixer

# Add Swagger codegen
RUN apt install -y default-jre \
	&& wget https://oss.sonatype.org/content/repositories/releases/io/swagger/swagger-codegen-cli/2.2.1/swagger-codegen-cli-2.2.1.jar -O /opt/swagger-codegen-cli.jar \
	&& echo -e '#!/bin/bash\njava -jar /opt/swagger-codegen-cli.jar $@' > /usr/bin/swagger-codegen \
	&& chmod +x /usr/bin/swagger-codegen

RUN	chmod +x /scripts/startup/*
ADD	rootfs /