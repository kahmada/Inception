FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y vsftpd && \
    apt-get clean

# Créer l’utilisateur ftpuser avec mot de passe
RUN useradd -m ftpuser && echo "ftpuser:ftppass" | chpasswd

# Configuration de vsftpd
COPY ./conf/vestpd.conf /etc/vsftpd.conf

# Créer le dossier qui sera lié au volume WordPress
RUN mkdir -p /var/www/html && chown ftpuser:ftpuser /var/www/html

EXPOSE 21

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
