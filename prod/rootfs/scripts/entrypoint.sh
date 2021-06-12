#!/bin/bash

echo "[STARTUP] Starting Symfony Web Container with NGINX and PHP"

source /scripts/environment.sh
run-parts /scripts/startup &

/usr/bin/supervisord