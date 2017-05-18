#!/bin/sh

BASEDIR=$(dirname "$0")

if [ -z "$IDT_MYSQL_DATA_DIR" ]; then
    echo
    echo "Please set the environment variable IDT_MYSQL_DATA_DIR to point the mysql datadir directory on host machine."
    exit 1
else
    echo "Ok -> \$IDT_MYSQL_DATA_DIR is $IDT_MYSQL_DATA_DIR"
fi

if [ -z "$IDT_MYSQL_PWD" ]; then
    echo
    echo "Please set the environment variable IDT_MYSQL_PWD to you mysql password."
    exit 1
  else
      echo "Ok -> \$IDT_MYSQL_PWD is $IDT_MYSQL_PWD"
  fi

echo
echo "Everything looks good... Pullling latest image"
echo

docker pull mysql:latest

echo
echo "Mysql datadir: $IDT_MYSQL_DATA_DIR"
echo "Mysql host: idt-mysql"
echo "Mysql username: root"
echo "Mysql password: $IDT_MYSQL_PWD"
