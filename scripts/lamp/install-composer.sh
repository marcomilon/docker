#!/bin/sh

BASEDIR=$(dirname "$0")
$BASEDIR/../../bin/php setup-composer.php

if [ $? -eq 0 ]
then
  mv $BASEDIR/composer.phar $BASEDIR/../../bin/composer
  rm $BASEDIR/composer-setup.php
  echo "Successfully installed composer"
else
  echo "Could not install composer"
fi
