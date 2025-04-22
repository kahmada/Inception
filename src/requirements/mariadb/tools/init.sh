#!/bin/bash

# Check if database directory is already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Initialize MySQL data directory
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MySQL service temporarily
    service mysql start

    # Create database and user
    mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    # Stop MySQL service
    service mysql stop
fi

# Start MySQL in foreground
exec mysqld_safe