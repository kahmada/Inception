FROM debian:buster

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy MariaDB configuration
COPY ./conf/my.conf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy initialization script (if necessary)
COPY ./tools/init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh

# Optionally, use Docker's entrypoint for MariaDB initialization
#COPY ./tools/init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

CMD ["/usr/local/bin/init.sh"]
