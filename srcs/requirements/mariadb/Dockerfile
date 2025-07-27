
FROM debian:bullseye

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y mariadb-server

COPY ./tools/init.sh /init.sh

RUN chmod +x /init.sh

ENTRYPOINT [ "./init.sh" ]
CMD [ "mysqld_safe" ]
