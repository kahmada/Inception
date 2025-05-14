
FROM debian:bullseye

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y mariadb-server

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/my.cnf
COPY ./tools/init.sh /init.sh

RUN chmod +x /init.sh

ENTRYPOINT [ "./init.sh" ]
CMD [ "mysqld_safe" ]
