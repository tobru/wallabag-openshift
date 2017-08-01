#!/bin/sh

configure () {

  sed -i 's/pdo_sqlite/pdo_mysql/' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@database_host: 127.0.0.1@database_host: '"$SYMFONY__DATABASE_HOST"'@' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@database_port: null@database_port: 3306@' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@database_name: symfony@database_name: '"$SYMFONY__DATABASE_NAME"'@' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@database_user: root@database_user: '"$SYMFONY__DATABASE_USER"'@' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@database_password: null@database_password: '"$SYMFONY__DATABASE_PASSWORD"'@' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@redis_host: localhost@redis_host: redis@' /var/www/wallabag/app/config/parameters.yml

  php bin/console cache:clear -e=prod

  if [ ! -f /var/www/wallabag/app/config/docker.done ]; then
    php bin/console wallabag:install --env=prod -n
    exit_status=$?
    if [ $exit_status -eq 1 ]; then
      echo "automatic installation failed"
    else
      echo $(date) > /var/www/wallabag/app/config/docker.done
    fi
  fi

}

if [ "$1" = "wallabag" ]; then
  configure
  exec s6-svscan /etc/s6/
fi

exec "$@"
