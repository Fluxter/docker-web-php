#!/bin/bash

echo "Starting Symfony Web Container with NGINX and PHP 7.4"

source /scripts/settings.sh
run-parts /scripts/startup &

/usr/bin/supervisord