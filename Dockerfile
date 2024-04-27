FROM php:8.0-apache
ENV TZ=Europe/Moscow
WORKDIR /var/www/html
RUN apt-get update && apt-get install -y libmariadb-dev
RUN docker-php-ext-install mysqli pdo_mysql pdo
RUN a2enmod rewrite

ADD ./src /var/www/html