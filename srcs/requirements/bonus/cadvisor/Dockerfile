FROM debian:bullseye

RUN apt-get update -y && apt-get install -y wget ca-certificates

RUN wget https://github.com/google/cadvisor/releases/download/v0.37.0/cadvisor -O /usr/local/bin/cadvisor && \
    chmod +x /usr/local/bin/cadvisor

EXPOSE 8080

CMD ["/usr/local/bin/cadvisor"]
