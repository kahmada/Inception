FROM debian:bullseye

# Install required dependencies and add the PHP repository
RUN apt update -y && apt install -y php php-fpm php-mysql curl
# Copie de la configuration WordPress personnalisée
COPY ./tools/wp-setup.sh /tmp/


RUN chmod +x /tmp/wp-setup.sh


RUN mkdir -p /run/php




ENTRYPOINT ["./tmp/wp-setup.sh"]

# Lancement de PHP-FPM en mode foreground
CMD ["php-fpm7.4", "-F"]
