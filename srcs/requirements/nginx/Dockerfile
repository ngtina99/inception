# For nginx → install nginx, set up SSL, serve PHP.

FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy your nginx config and certificates (see below)
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./certs /etc/nginx/certs
COPY ./html /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]