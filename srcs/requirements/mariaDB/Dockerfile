FROM debian:13.2

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        mariadb-server && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld /var/lib/mysql

COPY tools/setup-mariadb.sh /usr/local/bin/
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x /usr/local/bin/setup-mariadb.sh

EXPOSE 3306

ENTRYPOINT ["setup-mariadb.sh"]