FROM php:7.3-fpm-stretch

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    ffmpeg \
    git \
    zlib1g-dev libicu-dev g++ \
    curl \
    libcurl3 \
    libcurl3-dev \
    libxml2-dev 



RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-configure soap --enable-soap && \
    docker-php-ext-install pdo_mysql \
    -j$(nproc) iconv \
    gd \
    zip \
    mysqli \
    intl bcmath ctype curl dom hash simplexml sockets

COPY ./libs/composer-setup.php ./
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

ARG WORKDIR
WORKDIR $WORKDIR  
