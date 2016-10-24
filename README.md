# Simple out of the box Docker Lamp Stack

You need to download and install Docker  
See [Docker](https://www.docker.com/)

Need more information about docker?  
Go to https://www.docker.com/what-docker

Feel free to send a Pull request to improve this package.

## What this package provide

You will get a ready to use Lamp Stack.
Mysql, Apache and Php with mcrypt, mysql extensions and Composer package manager.
Tested on Linux and Macos

## What is the scope of this package

I want to provide an easy to use Lamp Stack. Not meant to be use on production.

## How do i set up the Lamp Stack

First you need to download the images. Launch the script *lamp-init.sh* in the libraries directory.

`sh libraries/lamp-init.sh`

This command will download the images. You need to execute this command every time you change your config file.

After you want to compose the Docker lamp Stack. You do it with the scrip *web-compose-init.sh* in the libraries directory.

For example

`sh libraries/web-compose-init.sh`

You need to execute this command every time you change your config file.

**You need to do this step only the first time**

## How to change the version of Mysql and Php

Update the config.cfg.

You can change the tags of the images easily. For example for php the default tag
is 5.6.26-apache you can easily change it to a newer version of php like 7.0

If you don't know what tag to use skip this step and leave the config
file with the default tags.

## How do i set up the DocumentRoot of Apache

Update the config.cfg: apache_document_root

## How do i set the root password of Mysql

Update the config.cfg: apache_document_root
