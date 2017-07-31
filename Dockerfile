FROM wallabag/wallabag
MAINTAINER Tobias Brunner <tobias@tobru.ch>

COPY root /
RUN chgrp -R 0 \
      /var/www/wallabag \
      /etc/s6 \
      /var/run \
      /var/log \
      && \
    chmod -R g+rwX \
      /var/www/wallabag \
      /etc/s6 \
      /var/run \
      /var/log
