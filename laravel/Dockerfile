# TODO(taru): Uses libanx1
FROM php:8.1-apache

ENV ANX1_ENV_LIB_LARAVEL_DB_DATABASE=/var/www/html/database/db/database.sqlite
ENV ANX1_ENV_LIB_LARAVEL_DB_SCHEMADIR=/var/www/html/database/schema/

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update && \
    apt-get install -y makepasswd git unzip libzip-dev libicu-dev libonig-dev nodejs npm libfreetype6-dev libjpeg62-turbo-dev libpng-dev sqlite3 && \
    docker-php-ext-install intl pdo_mysql zip bcmath gd && \
    a2enmod rewrite && \
    apt auto-clean

USER www-data:www-data

RUN composer create-project laravel/laravel /var/www/html && \
    sed -i \
        -e 's/DB_CONNECTION=mysql/DB_CONNECTION=sqlite/' \
        -e "s!DB_DATABASE=.*!DB_DATABASE=$ANX1_ENV_LIB_LARAVEL_DB_DATABASE!" \
        /var/www/html/.env && \
    install -d $ANX1_ENV_LIB_LARAVEL_DB_SCHEMADIR && \
    install -d $(dirname $ANX1_ENV_LIB_LARAVEL_DB_DATABASE) && \
    touch $ANX1_ENV_LIB_LARAVEL_DB_DATABASE

COPY php.ini /usr/local/etc/php/php.ini
COPY default.conf /etc/apache2/sites-enabled/000-default.conf
COPY entrypoint create_htpasswd.sh /srv/anx1/lib/laravel/

WORKDIR /var/www/html
ENTRYPOINT ["/srv/anx1/lib/laravel/entrypoint"]

USER root:root
