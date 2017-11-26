#!/bin/bash

if test "$#" -ne 1; then
    echo "student name is required"
    exit 1
fi

mkdir -p php/students/$1/examples
mkdir -p php/students/$1/curso
cp php/code/* php/students/$1/examples
cp php/code/* php/students/$1/curso
(export DOCUMENT_ROOT="$(pwd)/php/students/$1/curso/" && docker-compose -f ../docker/lamp/fs/docker-compose.yml up -d)
