#!/bin/bash

export DOCKER_HOST_IP=`ip -4 route list match 0/0 | awk '{print $3}'`