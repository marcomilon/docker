#!/bin/sh

BASEDIR=$(dirname "$0")

docker build -f $BASEDIR/php/cli/Dockerfile -t idt/php:cli .

echo "Clean up build image"
docker rmi php:apache

docker build -f $BASEDIR/php/apache/Dockerfile -t idt/php:apache .

echo "Clean up build image"
docker rmi php:apache
