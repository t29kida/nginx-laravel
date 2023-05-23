FROM php:fpm-alpine3.17

RUN apk update && apk add bash

COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /app

EXPOSE 8000
