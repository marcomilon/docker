#!/bin/sh

BASEDIR=$(dirname "$0")

docker build -f $BASEDIR/DockerfileNode -t idt/node:grunt-cli .

echo "Clean up build image"
docker rmi node:6.9.1-alpine
echo
echo "done"
