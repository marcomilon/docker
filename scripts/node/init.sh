#!/bin/sh
docker build -f Dockerfile -t node:idt .

echo "Clean up build image"
docker rmi node:latest
echo
echo "done"
