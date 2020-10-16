#!/bin/bash

export FILE_PARAMETERS_DIST=$APP_ROOT/.env.local.dist
export FILE_PARAMETERS=$APP_ROOT/.env.local

export DOCKER_HOST_IP=`ip -4 route list match 0/0 | awk '{print $3}'`