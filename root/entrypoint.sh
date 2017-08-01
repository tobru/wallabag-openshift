#!/bin/sh

configure () {

  if [ ! -f /var/www/wallabag/app/config/parameters.yml ]; then
    echo "---> bootstrapping config directory"
    tar xzf /tmp/wallabag-config.tgz -C / --no-overwrite-dir
  fi

  echo "---> editing parameters.yml"
  sed -i 's/pdo_sqlite/pdo_mysql/' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@database_host: 127.0.0.1@database_host: '"$SYMFONY__DATABASE_HOST"'@' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@database_port: null@database_port: 3306@' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@database_name: symfony@database_name: '"$SYMFONY__DATABASE_NAME"'@' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@database_user: root@database_user: '"$SYMFONY__DATABASE_USER"'@' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@database_password: null@database_password: '"$SYMFONY__DATABASE_PASSWORD"'@' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@redis_host: localhost@redis_host: redis@' /var/www/wallabag/app/config/parameters.yml
  sed -i 's@fosuser_registration: true@fosuser_registration: '"$FOSUSER_REGISTRATION"'@' /var/www/wallabag/app/config/parameters.yml

  echo "---> clear application cache"
  php bin/console cache:clear -e=prod
  echo "---> clear application cache - done"

  # Automatic Wallabag installation - if not yet done
  if [ ! -f /var/www/wallabag/app/config/docker.done ]; then
    echo "---> starting automatic wallabag installation"
    php bin/console wallabag:install --env=prod -n
    exit_status=$?
    if [ $exit_status -eq 1 ]; then
      echo "---> automatic installation failed"
    else
      echo "---> automatic installation finished"
      echo $(date) > /var/www/wallabag/app/config/docker.done
    fi
  fi

}

if [ "$1" = "wallabag" ]; then
  configure
  exec s6-svscan /etc/s6/
fi

exec "$@"
