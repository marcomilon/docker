#!/bin/sh

BASEDIR=$(dirname "$0")

docker build -f $BASEDIR/DockerfilePhp -t idt/web:5.6-mcrypt-gd-mysql .

echo
docker pull mysql:5.7

echo
docker pull phpmyadmin/phpmyadmin:4.6.4-1

echo
docker pull composer/composer:1.2-alpine
echo

echo "Clean up build image"
docker rmi php:5.6.26-apache
echo
echo "done"
