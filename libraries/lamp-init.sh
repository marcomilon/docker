#!/bin/sh
BASEDIR=$(dirname "$0")

config="$BASEDIR/../config.cfg"

if [ ! -r "$config" ];
then
  echo "Config file not found"
  exit
else
  . $config # read config file
fi

php_image="php:$php_tag"
echo "Creating Dockerfile for webserver"
sed "s/:image/$php_image/g" $BASEDIR/templates/WebServerFile > $BASEDIR/tmp/Dockerfile

if [ $php_ext_gd -eq 1 ];
then
  cat $BASEDIR/templates/php_ext/gd >> $BASEDIR/tmp/Dockerfile
fi

if [ $php_ext_mcrypt -eq 1 ];
then
  cat $BASEDIR/templates/php_ext/mcrypt >> $BASEDIR/tmp/Dockerfile
fi

if [ $php_ext_mysql -eq 1 ];
then
  cat $BASEDIR/templates/php_ext/mysql >> $BASEDIR/tmp/Dockerfile
fi

if [ $mod_rewrite -eq 1 ];
then
  cat $BASEDIR/templates/apache_mod/mod_rewrite >> $BASEDIR/tmp/Dockerfile
fi

docker build -f $BASEDIR/tmp/Dockerfile -t $php_image_tag .
rm $BASEDIR/tmp/Dockerfile

echo
mysql_image="mysql:$mysql_tag"
docker pull $mysql_image

echo
phpmyadmin_image="phpmyadmin/phpmyadmin:$phpmyadmin_tag"
docker pull $phpmyadmin_image

echo
composer_image="composer/composer:$composer_tag"
docker pull $composer_image
echo

echo "Clean up build image"
docker rmi $php_image
echo
echo "Docker images built:"
echo $php_image
echo $mysql_image
echo $phpmyadmin_image
echo $composer_image
echo
echo "done"
