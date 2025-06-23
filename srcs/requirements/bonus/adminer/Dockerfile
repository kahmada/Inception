FROM debian:bullseye

RUN apt-get update && apt-get install -y wget php php-mysql

RUN mkdir -p /var/www/html

RUN wget "https://www.adminer.org/latest.php" -O /var/www/html/index.php

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
