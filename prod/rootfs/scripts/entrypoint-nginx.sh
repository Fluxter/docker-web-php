#!/bin/bash

source /scripts/environment.sh

echo $WEBSPACE_ROOT;
sed -i "/ root/c\root $WEBSPACE_ROOT;" /etc/nginx/sites-available/app.conf
sed -i "/ root/c\root $WEBSPACE_ROOT;" /etc/nginx/sites-available/app_ssl.conf

FILE_SSL_KEY=/home/www-data/ssl/nginx-app.key
FILE_SSL_CRT=/home/www-data/ssl/nginx-app.crt
if [ ! -f "$FILE_SSL_KEY" ]; then
    echo "Generating new self-signed keys!"
    sudo -u www-data openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $FILE_SSL_KEY -out $FILE_SSL_CRT -subj "/C=US/ST=some-state/L=some-city/O=some-organisation/CN=symfony-app"
fi

nginx
