#!/bin/sh

provisioner () {
    echo "Starting provisioner..."
    mkdir -p /var/www/wallabag/app
    mkdir -p /var/www/wallabag/app/config
    mkdir -p /var/www/wallabag/data
    mkdir -p /var/www/wallabag/data/assets
    mkdir -p /var/www/wallabag/data/db
    echo "Provisioner finished."
}

if [ "$1" = "wallabag" ];then
    provisioner
    exec s6-svscan /etc/s6/
fi

exec "$@"
