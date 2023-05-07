FROM debian:bullseye-slim

RUN apt-get update -y
RUN apt-get install squid-common squidclient squid-openssl -y
RUN /usr/lib/squid/security_file_certgen -c -s /var/spool/squid/ssl_db -M 16MB

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN mkdir -p /var/spool/squid/data


RUN chown proxy:proxy -R /usr/lib/squid
RUN chown proxy:proxy -R /var/spool/squid
RUN chown proxy:proxy -R /etc/squid

ENTRYPOINT [ "entrypoint.sh" ]

CMD ["-f", "/etc/squid/squid.conf", "-NYC"]