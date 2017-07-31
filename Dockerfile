FROM wallabag/wallabag
MAINTAINER Tobias Brunner <tobias@tobru.ch>

WORKDIR /var/www/wallabag
RUN SYMFONY_ENV=prod composer install --no-dev -o --prefer-dist && \
    echo "Fixing directory permissions" && \
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
      /var/tmp/nginx && \
    echo "Finished fixing directory permissions"

COPY root /
