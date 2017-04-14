#!/bin/sh

BASEDIR=$(dirname "$0")
$BASEDIR/../../bin/php setup-composer.php

if [ $? -eq 0 ]
then
  mv $BASEDIR/composer.phar $BASEDIR/../../bin/composer.phar
  rm $BASEDIR/composer-setup.php
  cat > $BASEDIR/../../bin/composer << EOF
  #!/bin/sh
  BASEDIR=$(dirname "$0")
  docker run -it --rm --name idt-php-script -v \$(pwd):/usr/src/myapp -w /usr/src/myapp php:latest php $(pwd)/../../bin/composer.phar
EOF
  echo "Successfully installed composer"
else
  echo "Could not install composer"
fi
