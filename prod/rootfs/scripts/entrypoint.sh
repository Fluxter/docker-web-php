#!/bin/bash

echo "[STARTUP] Starting Symfony Web Container with NGINX and PHP"

source /scripts/settings.sh
run-parts /scripts/startup &

/usr/bin/supervisord