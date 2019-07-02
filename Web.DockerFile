ARG PHP_VERSION=7.1.30

# Use this image as the base image for dev and prod.
FROM php:${PHP_VERSION}-apache as common

RUN docker-php-ext-install mysqli;
RUN apt-get update;

# This is the image using in development.
FROM common as dev

RUN apt-get install -y zip unzip git; \
    pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini;

# Copy composer binary from official Composer image.
COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# We enable the errors only in development.
ENV DISPLAY_ERRORS="On"


# In this image we will download the dependencies, but without the development dependencies.
# The dependencies are installed in the vendor folder that will be copied later into the prod image.
FROM composer as builder-prod

WORKDIR /app

COPY composer.json composer.lock /app/
RUN composer install  \
    --ignore-platform-reqs \
    --no-ansi \
    --no-dev \
    --no-autoloader \
    --no-interaction \
    --no-scripts

# We need to copy our whole application so that we can generate the autoload file inside the vendor folder.
COPY . /app
RUN composer dump-autoload --optimize --no-dev --classmap-authoritative



# This is the image that will be deployed on production.
FROM common as prod

# No display errors to users in production.
ENV DISPLAY_ERRORS="Off"

# Copy our application
COPY . /var/www/html/
# Copy the downloaded dependencies from the builder-prod stage.
COPY --from=builder-prod /app/vendor /var/www/html/vendor



