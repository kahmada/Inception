FROM debian:bullseye

# Installation de nginx
RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copie les fichiers de ton site dans le dossier servi par nginx
COPY site/ /var/www/html/

# Remplace la config par défaut si nécessaire
# COPY default.conf /etc/nginx/sites-available/default  (optionnel)

# Expose le port utilisé
EXPOSE 80

# Lance nginx en mode foreground
CMD ["nginx", "-g", "daemon off;"]