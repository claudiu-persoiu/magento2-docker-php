FROM php:7.1-fpm
MAINTAINER Claudiu Persoiu claudiu@persoiu.ro

ENV WWW_DATA_UID 1000
ENV WWW_DATA_GID 1000

RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libxslt1-dev

RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
  bcmath \
  gd \
  intl \
  mbstring \
  mcrypt \
  pdo_mysql \
  soap \
  xsl \
  zip

RUN curl -sS https://getcomposer.org/installer | \
  php -- --install-dir=/usr/local/bin --filename=composer

ENV PHP_MEMORY_LIMIT 2G
ENV PHP_PORT 9000
ENV PHP_PM dynamic
ENV PHP_PM_MAX_CHILDREN 10
ENV PHP_PM_START_SERVERS 4
ENV PHP_PM_MIN_SPARE_SERVERS 2
ENV PHP_PM_MAX_SPARE_SERVERS 6
ENV APP_MAGE_MODE developer

COPY conf/php.ini /usr/local/etc/php/
COPY conf/php-fpm.conf /usr/local/etc/
COPY bin/entrypoint.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html

RUN pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug
COPY conf/xdebug.ini /usr/local/etc/php/conf.d/
RUN cat /usr/local/etc/php/conf.d/xdebug.ini >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN rm /usr/local/etc/php/conf.d/xdebug.ini

CMD ["/usr/local/bin/entrypoint.sh"]
