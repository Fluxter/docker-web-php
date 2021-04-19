#!/bin/bash

while [ ! -f /tmp/CONTAINER_STARTED ]
do
    echo "App / Container is still starting..."
    sleep 5
done