
FROM debian:bullseye


RUN apt update -y && apt install -y php php-fpm php-mysql curl

COPY ./tools/wp-setup.sh /tmp/

RUN chmod +x /tmp/wp-setup.sh

RUN mkdir -p /run/php


ENTRYPOINT ["./tmp/wp-setup.sh"]


CMD ["php-fpm7.4", "-F"]
        