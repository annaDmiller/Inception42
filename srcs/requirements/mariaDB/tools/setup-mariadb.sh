#!/bin/bash
set -e

DATADIR="/var/lib/mysql"

: "${MYSQL_DATABASE:?Need MYSQL_DATABASE}"
: "${MYSQL_USER:?Need MYSQL_USER}"
: "${MYSQL_PASSWORD:?Need MYSQL_PASSWORD}"
: "${MYSQL_ROOT_PASSWORD:?Need MYSQL_ROOT_PASSWORD}"

chown -R mysql:mysql "$DATADIR" /run/mysqld

if [ ! -d "$DATADIR/mysql" ]; then
    echo "First start, initializing datadir..."
    mysql_install_db --user=mysql --datadir="$DATADIR" --basedir=/usr

    echo "Start temp MariaDB..."
    mysqld --user=mysql --datadir="$DATADIR" --skip-networking &
    pid="$!"
    sleep 5

    echo "Configure root, database and user..."
    mysql -u root <<-EOSQL
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL

    echo "Stop temp MariaDB..."
    kill "$pid"
    wait "$pid" 2>/dev/null || true
fi

echo "Start MariaDB..."
exec mysqld --user=mysql --datadir="$DATADIR"