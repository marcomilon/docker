version: '2'
services:
  web:
    image: :php_image_tag
    container_name: :apache_container_name
    restart: always
    volumes:
      - :apache_document_root:/var/www/html
    depends_on:
      - db
    links:
      - db
    ports:
      - :apache_container_port:80
  db:
    image: mysql::mysql_tag
    container_name: :mysql_container_name
    restart: always
    volumes:
      - :base_dir/datadir:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: :mysql_root_password
  phpmyadmin:
    image: phpmyadmin/phpmyadmin::phpmyadmin_tag
    container_name: :phpmyadmin_container_name
    restart: always
    links:
      - db
    ports:
      - :phpmyadmin_port:80
