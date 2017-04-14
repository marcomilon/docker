FROM php:latest

# Install git
RUN apt-get update && apt-get install -y \
        git

# Install zip
RUN apt-get update && \
    apt-get install -y \
        zlib1g-dev

# Install mysql
RUN apt-get update && docker-php-ext-install zip
