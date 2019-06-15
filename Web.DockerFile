FROM composer:1.7 as vendor

WORKDIR /app
COPY composer.json composer.json

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

FROM php:7.1.29-apache

COPY --from=vendor  /app/vendor /var/www/html/vendor
COPY --from=vendor /app/composer.lock /var/www/html/composer.lock

ARG DEV=0
RUN if [ $DEV -eq 1 ] ; then \
        pecl install xdebug \
        && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini; \
    fi ;