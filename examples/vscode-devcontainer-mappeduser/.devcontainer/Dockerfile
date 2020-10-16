FROM fluxter/web-php-dev:7.4
RUN groupmod --gid 1000 www-data
RUN usermod --uid 1000 --gid 1000 www-data

RUN chown -R www-data:www-data /var/lib/nginx /var/log/nginx /etc/nginx