#!/bin/bash

# Initialiser la base de données si elle n'existe pas
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initialisation de MariaDB..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

# Démarrer MariaDB temporairement en arrière-plan
mysqld_safe --skip-networking &
sleep 5

# Vérifier si la base de données est accessible avant d'exécuter les commandes
until mysql -u root -e "SELECT 1"; do
    echo "Attente de la disponibilité de MariaDB..."
    sleep 2
done

# Exécuter les commandes SQL directement
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Arrêter MariaDB temporaire (démarrée en background)
mysqladmin shutdown

# Redémarrer MariaDB proprement au premier plan
exec mysqld_safe
