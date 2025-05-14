FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy NGINX configuration
COPY ./conf/nginx.conf /etc/nginx/sites-available/default

# Copy SSL setup script
COPY ./tools/ssl-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/ssl-setup.sh

# Run SSL setup (ensure this does not run multiple times unnecessarily)
RUN /usr/local/bin/ssl-setup.sh

CMD ["nginx", "-g", "daemon off;"]
