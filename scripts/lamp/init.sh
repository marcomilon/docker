#!/bin/sh

BASEDIR=$(dirname "$0")
echo "Creating lamp stack"
echo "You need to setup 3 environment variable: IDT_APACE_DOCUMENT_ROOT, IDT_MYSQL_DATA_DIR, IDT_MYSQL_PWD"

if [ -z "$IDT_APACE_DOCUMENT_ROOT" ]; then
    echo
    echo "Please set the environment variable IDT_APACE_DOCUMENT_ROOT to point the Apache document root directory on host machine."
    exit 1
else
    echo "Ok -> \$IDT_APACE_DOCUMENT_ROOT is $IDT_APACE_DOCUMENT_ROOT"
fi

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
echo "Everything looks good... Pullling images"
echo
sh $BASEDIR/pull-php.sh
sh $BASEDIR/pull-php-apache.sh
sh $BASEDIR/pull-mysql.sh

read -p "Would you like to install composer? [Y/n] " composer
if [[ $composer == Y* ]]; then
    echo "Downloading composer."
    sh $BASEDIR/install-composer.sh
else
    echo "Skipping composer installation."
fi

echo

read -p "Would you like to install phpmyadmin in $IDT_APACE_DOCUMENT_ROOT? [Y/n] " phpmyadmin
if [[ $phpmyadmin == Y* ]]; then
  echo "Downloading phpmyadmin."
    sh $BASEDIR/install-phpmyadmin.sh
else
    echo "Skipping phpmyadmin installation."
fi

echo
echo "Apache document root: $IDT_APACE_DOCUMENT_ROOT"
echo "Mysql datadir: $IDT_MYSQL_DATA_DIR"
echo "Mysql host: idt-mysql";
echo "Mysql username: root";
echo "Mysql password: $IDT_MYSQL_PWD"
