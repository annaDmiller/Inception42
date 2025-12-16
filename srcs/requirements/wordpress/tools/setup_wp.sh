#!/bin/sh
set -e

if [ -n "$MYSQL_HOST" ]; then
    echo "Waiting for MariaDB at ${MYSQL_HOST}:3306..."
    while ! nc -z "$MYSQL_HOST" 3306; do
        sleep 1
    done
    echo "MariaDB is up."
fi

cd /var/www/html

if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php..."

    cp wp-config-sample.php wp-config.php

    # Replace database settings using env vars
    sed -i "s/database_name_here/${MYSQL_DATABASE}/" wp-config.php
    sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
    sed -i "s/password_here/${MYSQL_PASSWORD}/" wp-config.php
    sed -i "s/localhost/${MYSQL_HOST:-mariadb}/" wp-config.php

    echo "wp-config.php created."
fi

exec php-fpm8.4 -F