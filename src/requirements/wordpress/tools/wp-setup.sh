#!/bin/bash

# Wait for MySQL to be ready
until mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "SELECT 1"; do
    echo "Waiting for MySQL to be ready..."
    sleep 5
done

# Download WordPress if not already installed
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Installing WordPress..."
    
    # Download WordPress
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -a wordpress/. /var/www/html/
    rm -rf wordpress latest.tar.gz
    
    # Create wp-config.php
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/$DB_NAME/g" /var/www/html/wp-config.php
    sed -i "s/username_here/$DB_USER/g" /var/www/html/wp-config.php
    sed -i "s/password_here/$DB_PASSWORD/g" /var/www/html/wp-config.php
    sed -i "s/localhost/$DB_HOST/g" /var/www/html/wp-config.php
    
    # Set authentication unique keys and salts
    SALT=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
    STRING='put your unique phrase here'
    printf '%s\n' "g/$STRING/d" a "$SALT" . w | ed -s /var/www/html/wp-config.php
    
    # Set proper permissions
    chown -R www-data:www-data /var/www/html
fi

# Start PHP-FPM
echo "Starting PHP-FPM..."
exec php-fpm7.3 -F