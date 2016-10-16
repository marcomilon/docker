#!/bin/sh

BASEDIR=$(dirname "$0")
config="../config.cfg"

if [ ! -r "$config" ];
then
  echo "Config file not found"
  exit
else
  . $config # read config file
fi

echo "Building webserver compose"

cd ..
base_dir=$(pwd);
cd libraries;

sed "s#:base_dir#$base_dir#g" templates/lamp-compose.tpl > ../compose/tmp/web-compose.yml.1
sed "s#:php_image_tag#$php_image_tag#g" ../compose/tmp/web-compose.yml.1 > ../compose/tmp/web-compose.yml.2
sed "s#:apache_container_name#$apache_container_name#g" ../compose/tmp/web-compose.yml.2 > ../compose/tmp/web-compose.yml.3
sed "s#:apache_container_port#$apache_container_port#g" ../compose/tmp/web-compose.yml.3 > ../compose/tmp/web-compose.yml.4
sed "s#:mysql_tag#$mysql_tag#g" ../compose/tmp/web-compose.yml.4 > ../compose/tmp/web-compose.yml.5
sed "s#:mysql_container_name#$mysql_container_name#g" ../compose/tmp/web-compose.yml.5 > ../compose/tmp/web-compose.yml.6
sed "s#:mysql_root_password#$mysql_root_password#g" ../compose/tmp/web-compose.yml.6 > ../compose/tmp/web-compose.yml.7
sed "s#:phpmyadmin_tag#$phpmyadmin_tag#g" ../compose/tmp/web-compose.yml.7 > ../compose/tmp/web-compose.yml.8
sed "s#:phpmyadmin_container_name#$phpmyadmin_container_name#g" ../compose/tmp/web-compose.yml.8 > ../compose/tmp/web-compose.yml.9
sed "s#:phpmyadmin_port#$phpmyadmin_port#g" ../compose/tmp/web-compose.yml.9 > ../compose/web-compose.yml

for i in `seq 1 9`;
do
  rm ../compose/tmp/web-compose.yml.$i
done
echo "Done"
