FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt install mariadb-server -y

COPY /conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY /tool/start.sh /

RUN chmod +x /start.sh

ENTRYPOINT ["bash", "/start.sh"]

CMD ["/usr/sbin/mysqld", "--bind-address=0.0.0.0"]
