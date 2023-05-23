FROM php:fpm-bullseye as development

RUN apt update && apt install -y bash unzip
COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . /app

EXPOSE 8000

FROM php:fpm-bullseye as build-stage

RUN apt update && apt install -y bash unzip
COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . /app
RUN composer install --optimize-autoloader --no-dev && \
    php artisan config:cache && \
    php artisan event:cache && \
    php artisan route:cache && \
    php artisan view:cache

FROM php:fpm-bullseye as staging

RUN apt update && apt install -y bash unzip
COPY --from=composer /usr/bin/composer /usr/bin/composer

USER nobody
WORKDIR /app
COPY --chown=nobody:nogroup --from=build-stage /app /app
