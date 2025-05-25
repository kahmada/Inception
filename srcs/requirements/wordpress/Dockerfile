# Cette ligne signifie que ton image part d’une base officielle Debian Bullseye (version stable de Debian). C’est ton système de base sur lequel tu vas tout installer (PHP, WordPress, etc.).
FROM debian:bullseye

# Install required dependencies and add the PHP repository
#Installe les paquets nécessaires :

#php : le langage PHP (essentiel pour WordPress),

#php-fpm : PHP en mode "FastCGI Process Manager", utilisé pour exécuter PHP de manière performante,

#php-mysql : extension PHP pour se connecter à MariaDB/MySQL,

#curl : utilitaire pour télécharger des fichiers depuis internet (utilisé souvent dans les scripts).

RUN apt update -y && apt install -y php php-fpm php-mysql curl
# Copie de la configuration WordPress personnalisée dans le dossier /tmp/ du conteneur.
COPY ./tools/wp-setup.sh /tmp/

#Rend le script exécutable avec les droits UNIX
RUN chmod +x /tmp/wp-setup.sh

#👉 Crée un dossier où PHP-FPM stockera ses fichiers runtime (comme les sockets).
#Cette ligne est importante pour éviter des erreurs au démarrage de PHP-FPM.
RUN mkdir -p /run/php



#👉 Cette ligne indique que le script /tmp/wp-setup.sh sera exécuté au lancement du conteneur, avant toute autre commande.
ENTRYPOINT ["./tmp/wp-setup.sh"]

# Lancement de PHP-FPM en mode foreground
CMD ["php-fpm7.4", "-F"]
#🔹 -F
#C’est une option importante : elle signifie "ne pas se détacher en arrière-plan" (foreground mode).

#Pourquoi c’est important dans Docker ? Parce que :

#Docker attend que le processus principal reste actif ;

#Si ton processus principal (ici PHP-FPM) se termine, Docker arrête le conteneur ;

#L’option -F dit à PHP-FPM de rester actif dans le terminal, ce qui permet à Docker de continuer à faire tourner le conteneur.