#!/bin/bash
set -e

DATADIR="/var/lib/mysql"

: "${MYSQL_DATABASE:?Need MYSQL_DATABASE}"
: "${MYSQL_USER:?Need MYSQL_USER}"
: "${MYSQL_PASSWORD:?Need MYSQL_PASSWORD}"
: "${MYSQL_ROOT_PASSWORD:?Need MYSQL_ROOT_PASSWORD}"

sed -i 's|MYSQL_DATABASE|'${MYSQL_DATABASE}'|g' /tmp/init.sql
sed -i 's|MYSQL_USER|'${MYSQL_USER}'|g' /tmp/init.sql
sed -i 's|MYSQL_PASSWORD|'${MYSQL_PASSWORD}'|g' /tmp/init.sql
sed -i 's|MYSQL_ROOT_PASSWORD|'${MYSQL_ROOT_PASSWORD}'|g' /tmp/init.sql

chown -R mysql:mysql "$DATADIR" /run/mysqld

if [ ! -d "$DATADIR/mysql" ]; then
    echo "First start, initializing datadir..."
    mysql_install_db --user=mysql --datadir="$DATADIR" --basedir=/usr

    echo "Start temp MariaDB..."
    mysqld --user=mysql --datadir="$DATADIR" --skip-networking &
    pid="$!"
    sleep 10

    echo "Configure root, database and user..."
    mysql --init-file="/tmp/init.sql"

    echo "Stop temp MariaDB..."
    kill "$pid"
    wait "$pid" 2>/dev/null || true
else
    echo "Data exists, starting normally..." 
fi

echo "Start MariaDB..."
exec mysqld --user=mysql --datadir="$DATADIR" --skip-networking=0