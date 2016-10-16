#!/bin/sh

config="../config.cfg"

if [ ! -r "$config" ];
then
  echo "Config file not found"
  exit
else
  . $config # read config file
fi

php_image="php:$php_tag"
echo "Creating Dockerfile for webserver"
sed "s/:image/$php_image/g" templates/WebServerFile > tmp/Dockerfile

if [ $php_ext_gd -eq 1 ];
then
  cat templates/php_ext/gd >> tmp/Dockerfile
fi

if [ $php_ext_mcrypt -eq 1 ];
then
  cat templates/php_ext/mcrypt >> tmp/Dockerfile
fi

if [ $php_ext_mysql -eq 1 ];
then
  cat templates/php_ext/mysql >> tmp/Dockerfile
fi

if [ $mod_rewrite -eq 1 ];
then
  cat templates/apache_mod/mod_rewrite >> tmp/Dockerfile
fi

docker build -f tmp/Dockerfile -t $php_image_tag .
rm tmp/Dockerfile

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

echo "done"
