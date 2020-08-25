ARG DOCKER_TAG
FROM fluxter/web-php:${DOCKER_TAG}

RUN apt update
RUN apt install -y php${DOCKER_TAG}-xdebug nano iputils-ping

RUN wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O /usr/bin/php-cs-fixer && chmod +x /usr/bin/php-cs-fixer

RUN apt install -y default-jre

# Add Swagger codegen
RUN wget https://repo1.maven.org/maven2/io/swagger/swagger-codegen-cli/2.4.15/swagger-codegen-cli-2.4.15.jar -O /opt/swagger-codegen-cli.jar \
	&& echo -e '#!/bin/bash\njava -jar /opt/swagger-codegen-cli.jar $@' > /usr/bin/swagger-codegen \
	&& chmod +x /usr/bin/swagger-codegen
	
# Add Openapi Codegen
RUN wget https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/5.0.0-beta/openapi-generator-cli-5.0.0-beta.jar -O /opt/openapi-generator.jar \
	&& echo -e '#!/bin/bash\njava -jar /opt/openapi-generator.jar $@' > /usr/bin/openapi-generator \
	&& chmod +x /usr/bin/openapi-generator

RUN	chmod +x /scripts/startup/*
ADD	rootfs /