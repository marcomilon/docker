#!/bin/bash

(export DOCUMENT_ROOT="$(pwd)/php/students/$1/curso/" && docker-compose -f ../docker/lamp/fs/docker-compose.yml up -d)
