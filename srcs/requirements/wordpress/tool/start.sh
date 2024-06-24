#!/bin/bash

sleep 10

if [ -f "/var/www/html/wordpress/wp-config.php" ]

then
	echo "Wordpress already installed and setup"
else
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
	wp core download --allow-root

	sleep 10
	
	wp config create --allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=mariadb:3306 --skip-check
	wp core install --allow-root --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email
	wp user create --allow-root $USER1 $USER1_EMAIL --user_pass=$USER1_PASS --role='contributor'
fi

exec "$@"