FROM php:5.6-fpm

RUN apt-get update && apt-get install -y \
    libicu-dev libpng-dev libjpeg-dev zlib1g-dev libfreetype6-dev libmcrypt-dev libxml2-dev \
    wget git unzip ca-certificates

# php extension for gd with free type
RUN docker-php-ext-configure gd --with-gd --with-jpeg-dir \
    --with-png-dir --with-zlib-dir --with-freetype-dir \
    --enable-gd-native-ttf

# php extensions
RUN docker-php-ext-install gd pdo mysqli pdo_mysql zip soap opcache sockets mcrypt

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# bitrix pool config
COPY php-fpm/bitrix.conf /usr/local/etc/php-fpm.d/bitrix.conf
ADD php-fpm/php.ini /usr/local/etc/php/php.ini

RUN mkdir /var/session && chown www-data:www-data /var/session

COPY nginx/example.local.crt /usr/local/share/ca-certificates/
COPY nginx/example.local.key /usr/local/share/ca-certificates/

# RUN update-ca-certificates

# MAIL
COPY php-fpm/mail_fake.php /usr/local/bin/mail_fake.php
RUN chmod 777 /usr/local/bin/mail_fake.php

WORKDIR WORKDIR_PHP
