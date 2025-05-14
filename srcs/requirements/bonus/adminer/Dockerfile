FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y php php-mysqli wget unzip curl && \
    rm -rf /var/lib/apt/lists/*

# Crée un dossier pour adminer
RUN mkdir -p /var/www/html

# Télécharge Adminer
RUN curl -o /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

# Copie le script de démarrage
COPY tools/start_adminer.sh /start_adminer.sh
RUN chmod +x /start_adminer.sh

EXPOSE 8080

CMD ["/start_adminer.sh"]
