#!/bin/bash

HTML_FOLDER="/var/www/html"


mkdir -p $HTML_FOLDER

sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|" /etc/php/7.4/fpm/pool.d/www.conf

cd $HTML_FOLDER

sleep 10


curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar


mv wp-cli.phar /usr/local/bin/wp

if [ ! -f /var/www/html/wp-config.php ]; then
        wp core download --allow-root --path=/var/www/html

        wp config create --dbname=$WORDPRESS_DB_NAME \
                        --dbuser=$WORDPRESS_DB_USER \
                        --dbpass=$WORDPRESS_DB_PASSWORD \
                        --dbhost=$WORDPRESS_DB_HOST \
                        --allow-root --path=/var/www/html

        wp core install --url=$DOMAIN_NAME \
                        --title="$WP_TITLE" \
                        --admin_user=$WP_ADMIN \
                        --admin_email=$WP_ADMIN_EMAIL \
                        --admin_password=$WP_ADMIN_PASSWORD \
                        --skip-email \
                        --allow-root --path=/var/www/html

        wp user create $WP_USER $WP_EMAIL --role=author \
                        --user_pass=$WORDPRESS_DB_PASSWORD \
                        --allow-root --path=/var/www/html
    
fi
chown -R www-data:www-data /var/www/html
echo "WordPress is already configured. Skipping installation."

exec $@


