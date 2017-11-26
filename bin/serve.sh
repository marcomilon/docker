#!/bin/bash

BASEDIR=$(dirname "$0")

(export DOCUMENT_ROOT="$(pwd)" && docker-compose -f $BASEDIR/../docker/lamp/ap/docker-compose.yml up -d)
