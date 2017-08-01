FROM wallabag/wallabag
MAINTAINER Tobias Brunner <tobias@tobru.ch>

WORKDIR /var/www/wallabag
RUN rm -rf /var/www/wallabag/var/cache/prod && \
    SYMFONY_ENV=prod composer install --no-dev -o --prefer-dist && \
    rm -rf /var/www/wallabag/var/cache/prod && \
    echo "Fixing directory permissions" && \
    chgrp -R 0 \
      /var/www/wallabag/app \
      /var/www/wallabag/var \
      /etc/s6 \
      /var/run \
      /var/log \
      /var/lib/nginx \
      /var/tmp/nginx \
    && \
    chmod -R g+rwX \
      /var/www/wallabag/app \
      /var/www/wallabag/var \
      /etc/s6 \
      /var/run \
      /var/log \
      /var/lib/nginx \
      /var/tmp/nginx && \
    echo "Finished fixing directory permissions"

COPY root /

VOLUME ["/var/www/wallabag/var"]

USER 1001
