FROM php:7.2-fpm

RUN apt-get update && apt-get install -y \
    libicu-dev libpng-dev libjpeg-dev zlib1g-dev libfreetype6-dev libmcrypt-dev libxml2-dev \
    wget git unzip ca-certificates
RUN pecl install xdebug-2.7.1 && docker-php-ext-enable xdebug
RUN pecl install mcrypt-1.0.2 && docker-php-ext-enable mcrypt

# php extension for gd with free type
RUN docker-php-ext-configure gd --with-gd --with-jpeg-dir \
    --with-png-dir --with-zlib-dir --with-freetype-dir

# php extensions
RUN docker-php-ext-install gd pdo mysqli pdo_mysql zip soap opcache sockets

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# bitrix pool config
COPY php-fpm/bitrix.conf /usr/local/etc/php-fpm.d/
COPY php-fpm/php.ini /usr/local/etc/php/

COPY nginx/example.local.crt /usr/local/share/ca-certificates/
COPY nginx/example.local.key /usr/local/share/ca-certificates/

# RUN update-ca-certificates

# change uid for nginx user to avoid problems with host permissions
ARG HOST_USER_ID
ARG HOST_GROUP_ID
RUN groupadd -g $HOST_GROUP_ID user && useradd -d /var/www/docker/user -s /bin/bash -u $HOST_USER_ID -g $HOST_GROUP_ID user

RUN mkdir /var/session && chown user:user /var/session

# MAIL
COPY php-fpm/mail_fake.php /usr/local/bin/mail_fake.php
RUN chown user:user /usr/local/bin/mail_fake.php

USER user

ARG WORKDIR_PHP
WORKDIR $WORKDIR_PHP
