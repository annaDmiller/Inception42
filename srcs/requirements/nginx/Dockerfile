FROM debian:13.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/nginx /etc/nginx/conf.d /etc/ssl/private /etc/ssl/certs /var/www/html

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/selfsigned.key \
    -out /etc/ssl/certs/selfsigned.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=student/CN=amelniko.42.fr"

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY conf/index.html /var/www/html/index.html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]