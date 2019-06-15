FROM php:7.1.29-apache

ARG DEV=0
RUN if [ $DEV -eq 1 ] ; then \
        pecl install -f xdebug \
        && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini; \
    fi ;