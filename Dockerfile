FROM wallabag/wallabag
MAINTAINER Tobias Brunner <tobias@tobru.ch>

COPY root /
WORKDIR /var/www/wallabag
RUN mkdir \
      /var/www/wallabag/data/assets \
    && \
    chgrp -R 0 \
      /var/www/wallabag \
      /etc/s6 \
      /var/run \
      /var/log \
      /var/lib/nginx \
      /var/tmp/nginx \
    && \
    chmod -R g+rwX \
      /var/www/wallabag \
      /etc/s6 \
      /var/run \
      /var/log \
      /var/lib/nginx \
      /var/tmp/nginx \
    && \
    rm -rf /var/www/wallabag/var/cache \
    && \
    SYMFONY_ENV=prod composer install --no-dev -o --prefer-dist

