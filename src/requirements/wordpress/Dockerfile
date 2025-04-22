FROM debian:buster

RUN apt-get update && apt-get install -y \
    php7.3-fpm \
    php7.3-mysql \
    php7.3-curl \
    php7.3-gd \
    php7.3-mbstring \
    php7.3-xml \
    php7.3-zip \
    wget \
    curl \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# Create directory for PHP-FPM to run
RUN mkdir -p /run/php

# Copy WordPress setup script
COPY ./tools/wp-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-setup.sh

WORKDIR /var/www/html

EXPOSE 9000

CMD ["/usr/local/bin/wp-setup.sh"]
