#!/bin/bash

HTML_FOLDER="/var/www/html"   #on a defini un variable folder qui contient le chemin vers le dossier où WordPress sera installé.

# Créer le répertoire HTML si nécessaire
mkdir -p $HTML_FOLDER

# Cette ligne modifie la configuration de PHP-FPM :

#Elle remplace listen = /run/php/php7.4-fpm.sock par listen = 9000 puisque il ont dit que la conextion est tcp et c est pas via socket

#Le fichier modifié est : /etc/php/7.4/fpm/pool.d/www.conf
sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|" /etc/php/7.4/fpm/pool.d/www.conf

cd $HTML_FOLDER
#Pour laisser le temps à MariaDB (base de données) de démarrer. Si la base n'est pas prête, l'installation de WordPress échouera.
sleep 10

# Télécharger et installer WP-CLI, l’outil en ligne de commande pour gérer WordPress.
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

#Déplace l’outil dans /usr/local/bin sous le nom wp.
mv wp-cli.phar /usr/local/bin/wp

# Vérifier si WordPress est déjà configuré et passer à l'étape suivante si oui
if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root
    #Crée le fichier wp-config.php avec :Nom de la base Utilisateur  Mot de passe  et Hôte (adresse IP ou nom du conteneur MariaDB)
    wp config create --dbname=$WORDPRESS_DB_NAME \
                     --dbuser=$WORDPRESS_DB_USER \
                     --dbpass=$WORDPRESS_DB_PASSWORD \
                     --dbhost=$WORDPRESS_DB_HOST \
                     --allow-root
    #nstalle WordPress avec : Adresse du site Titre Admin + mot de passe Email admin   On ne veut pas envoyer de mail (--skip-email)
    wp core install --url=$DOMAIN_NAME \
                    --title="$WP_TITLE" \
                    --admin_user=$WP_ADMIN \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --skip-email \
                    --allow-root
    #Crée un utilisateur supplémentaire avec le rôle d’auteur.
    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WORDPRESS_DB_PASSWORD --allow-root
else
    echo "WordPress is already configured. Skipping installation."
fi

# Lancer PHP-FPM pour PHP 7.4 ou la version correspondante
#➡️ Cette commande exécute le processus principal passé par Docker (c’est le CMD ["php-fpm7.4", "-F"]).
exec $@


#Ce script :
#Configure PHP-FPM pour écouter sur le port 9000 (TCP),
#Télécharge et installe WordPress si ce n’est pas déjà fait,
#Configure le site avec WP-CLI (base de données, admin, utilisateur),
#Lance PHP-FPM pour faire tourner WordPress.


