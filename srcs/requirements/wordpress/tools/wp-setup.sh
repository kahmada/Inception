#!/bin/bash

HTML_FOLDER="/var/www/html"

# Créer le répertoire HTML si nécessaire
mkdir -p $HTML_FOLDER

# Assure-toi que PHP-FPM utilise le bon socket ou port (si nécessaire)
sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|" /etc/php/7.4/fpm/pool.d/www.conf

cd $HTML_FOLDER
sleep 10

# Télécharger et installer WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Vérifier si WordPress est déjà configuré et passer à l'étape suivante si oui
if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root
    wp config create --dbname=$WORDPRESS_DB_NAME \
                     --dbuser=$WORDPRESS_DB_USER \
                     --dbpass=$WORDPRESS_DB_PASSWORD \
                     --dbhost=$WORDPRESS_DB_HOST \
                     --allow-root
    wp core install --url=$DOMAINE_NAME \
                    --title="$WP_TITLE" \
                    --admin_user=$WP_ADMIN \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --skip-email \
                    --allow-root
    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root
else
    echo "WordPress is already configured. Skipping installation."
fi

# Lancer PHP-FPM pour PHP 7.4 ou la version correspondante
exec $@

