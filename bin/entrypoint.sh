#!/bin/bash
BASE_DIR=/var/www
SRC_DIR=$BASE_DIR/html

usermod -u ${WWW_DATA_UID=1000} www-data
groupmod -g ${WWW_DATA_GID=1000} www-data

if [ -d $BASE_DIR/.composer ]; then
  rm -rf $SRC_DIR/var/composer_home
  su -c "ln -s $BASE_DIR/.composer $SRC_DIR/var/composer_home" -s /bin/sh www-data
fi

# for the www-data user to use
echo "PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT}" >> /etc/environment
echo "APP_MAGE_MODE=${APP_MAGE_MODE}" >> /etc/environment

/usr/local/sbin/php-fpm