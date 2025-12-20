FROM debian:13.2

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        php-fpm php-mysql php-mbstring php-xml php-curl php-zip \
        curl tar ca-certificates netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzf wordpress.tar.gz --strip-components=1 && \
    rm wordpress.tar.gz

COPY conf/www.conf /etc/php/8.4/fpm/pool.d/www.conf

COPY tools/setup_wp.sh /usr/local/bin/setup_wordpress.sh
RUN chmod +x /usr/local/bin/setup_wordpress.sh

EXPOSE 9000

CMD ["setup_wordpress.sh"]