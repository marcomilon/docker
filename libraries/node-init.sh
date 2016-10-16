#!/bin/sh

config="../config.cfg"

if [ ! -r "$config" ];
then
  echo "Config file not found"
  exit
else
  . $config # read config file
fi

node_image="node:$node_tag"
echo "Creating Dockerfile for node"

sed "s/:image/$node_image/g" templates/NodeJsFile > tmp/Dockerfile_tmp

if [ $grunt_cli -eq 1 ];
then
  install_grunt=$(<templates/node_packages/grunt-cli)
  sed "s/:grunt_cli/$install_grunt/g" tmp/Dockerfile_tmp > tmp/Dockerfile
else
  sed "s/:grunt_cli//g" tmp/Dockerfile_tmp > tmp/Dockerfile
fi

docker build -f tmp/Dockerfile -t $node_image_tag .

rm tmp/Dockerfile_tmp tmp/Dockerfile

if [ $jekyll -eq 1 ];
then
  jekyll_image="jekyll/jekyll:$jekyll_tag"
  docker pull $jekyll_image
fi

echo
echo "done"

# echo "Pulling node"
# docker pull node
# echo "Pulling jekyll"
# docker pull jekyll/jekyll
# echo "Building node server"
# sh ./buildNodeServer.sh
# echo "docker init done"
