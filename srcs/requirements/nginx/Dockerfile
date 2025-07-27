FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


COPY ./conf/nginx.conf /etc/nginx/sites-available/default


COPY ./tools/ssl-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/ssl-setup.sh


RUN /usr/local/bin/ssl-setup.sh

CMD ["nginx", "-g", "daemon off;"]
