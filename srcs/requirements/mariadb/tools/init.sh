#!/bin/bash


if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initialisation de MariaDB..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi


mysqld_safe --skip-networking &
sleep 5


until mysql -u root -e "SELECT 1"; do
    echo "Attente de la disponibilité de MariaDB..."
    sleep 2
done


mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF



mysqladmin shutdown


exec mysqld_safe
