FROM debian:bullseye

RUN	apt update -y && apt upgrade -y

RUN	apt-get -y install php php-fpm php-cli php-mysql php-curl php-gd php-intl mariadb-client wget

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir /run/php
RUN chmod +x /run/php

COPY ./tool/start.sh /usr/local/bin/start.sh
RUN	chmod +x /usr/local/bin/start.sh
ENTRYPOINT ["bash", "/usr/local/bin/start.sh"]

RUN mkdir -p /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html/wordpress
WORKDIR	/var/www/html/wordpress/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
