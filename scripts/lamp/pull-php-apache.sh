#!/bin/sh

BASEDIR=$(dirname "$0")

docker build -f $BASEDIR/DockerfilePhpApache -t idt/apache:php-mcrypt-gd-mysql .

echo "Clean up build image"
docker rmi php:apache
