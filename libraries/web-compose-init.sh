#!/bin/sh

CURDIR=$(dirname "$0")
config="$CURDIR/../config.cfg"

if [ ! -r "$config" ];
then
  echo "Config file not found"
  exit
else
  . $config # read config file
fi

echo "Building webserver compose"

cd $CURDIR/../
base_dir=$(pwd);

if [ -z "$mysql_root_password" ];
then
  mysql_root_password=$(cat /dev/random | LC_CTYPE=C tr -dc "[:alpha:]" | head -c 8)
fi

if [ -z "$apache_document_root" ];
then
  mkdir -p "$CURDIR/../sites/"
  apache_document_root="$CURDIR/../sites/"
elif [ ! -d "$apache_document_root" ];
then
  mkdir -p "$apache_document_root"
fi

# This sucks i dont know how to make it better
sed "s#:base_dir#$base_dir#g" $base_dir/libraries/templates/lamp-compose.tpl > $base_dir/libraries/tmp/web-compose.yml.1
sed "s#:php_image_tag#$php_image_tag#g" $base_dir/libraries/tmp/web-compose.yml.1 > $base_dir/libraries/tmp/web-compose.yml.2
sed "s#:apache_container_name#$apache_container_name#g" $base_dir/libraries/tmp/web-compose.yml.2 > $base_dir/libraries/tmp/web-compose.yml.3
sed "s#:apache_container_port#$apache_container_port#g" $base_dir/libraries/tmp/web-compose.yml.3 > $base_dir/libraries/tmp/web-compose.yml.4
sed "s#:apache_document_root#$apache_document_root#g" $base_dir/libraries/tmp/web-compose.yml.4 > $base_dir/libraries/tmp/web-compose.yml.5
sed "s#:mysql_tag#$mysql_tag#g" $base_dir/libraries/tmp/web-compose.yml.5 > $base_dir/libraries/tmp/web-compose.yml.6
sed "s#:mysql_container_name#$mysql_container_name#g" $base_dir/libraries/tmp/web-compose.yml.6 > $base_dir/libraries/tmp/web-compose.yml.7
sed "s#:mysql_root_password#$mysql_root_password#g" $base_dir/libraries/tmp/web-compose.yml.7 > $base_dir/libraries/tmp/web-compose.yml.8
sed "s#:phpmyadmin_tag#$phpmyadmin_tag#g" $base_dir/libraries/tmp/web-compose.yml.8 > $base_dir/libraries/tmp/web-compose.yml.9
sed "s#:phpmyadmin_container_name#$phpmyadmin_container_name#g" $base_dir/libraries/tmp/web-compose.yml.9 > $base_dir/libraries/tmp/web-compose.yml.10
sed "s#:phpmyadmin_port#$phpmyadmin_port#g" $base_dir/libraries/tmp/web-compose.yml.10 > $base_dir/compose/web-compose.yml

for i in `seq 1 9`;
do
  rm $base_dir/libraries/tmp/web-compose.yml.$i
done

cd $base_dir/compose
compose_dir=$(pwd);

cd $apache_document_root
apache_document_root=$(pwd);

echo
echo "A new Docker compose file was created in $compose_dir/web-compose.yml"
echo "You can start your new Lamp evairoment with: docker-compose -f $compose_dir/web-compose.yml up -d"
echo
read -p "Do you want to start Lamp now? [Y/n] " -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Done"
    exit 1
fi
docker-compose -f $compose_dir/web-compose.yml up -d
echo
echo "Your DocumentRoot: $apache_document_root"
echo "Apache: http://localhost:$apache_container_port"
echo "Phpmyadmin: http://localhost:$phpmyadmin_port"
echo "Your mysql password is: $mysql_root_password"
echo
echo "Done"
