#!/bin/bash

service mariadb start
sleep 5

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
EOF

mysqladmin shutdown

exec mysqld_safe --bind-address=0.0.0.0





# إذا استعملت exec:
# mysqld_safe كيولي هو البرنامج الرئيسي (PID 1).

# إيلا درتي docker stop، السيجنال كيمشي مباشرة لMa