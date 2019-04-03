FROM php:7.1-fpm

# Install system requirements
RUN apt-get update && apt-get install -y \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql zip

WORKDIR "/var/www"
