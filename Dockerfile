FROM ubuntu:18.04

ENV LC_ALL=C.UTF-8
WORKDIR /var/www

RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests nginx php7.2 php7.2-fpm ca-certificates gettext curl && \
    rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/nginx/sites-enabled/* && rm -f /var/www/html/index.nginx-debian.html

COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php/7.2/fpm/php-fpm.conf
COPY defaults.ini /etc/php/7.2/cli/conf.d/defaults.ini
COPY defaults.ini /etc/php/7.2/fpm/conf.d/defaults.ini
ADD index.php index.php

RUN mkdir -p /run/php && touch /run/php/php7.2-fpm.sock && touch /run/php/php7.2-fpm.pid

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
