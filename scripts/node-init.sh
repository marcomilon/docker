#!/bin/sh

BASEDIR=$(dirname "$0")

docker build -f $BASEDIR/NodeDockerfile -t idt/node:grunt-cli .

echo "Clean up build image"
docker rmi node:4.6.1
echo
echo "done"
