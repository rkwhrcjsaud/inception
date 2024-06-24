#!/bin/bash
/etc/init.d/mariadb start
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | mysql_secure_installation
	  # current root password (emtpy after installation)
	y # Set root password?
	${SQL_ROOT_PASSWORD} # new root password
	${SQL_ROOT_PASSWORD} # new root password
	y # Remove anonymous users?
	y # Disallow root login remotely?
	y # Remove test database and access to it?
	y # Reload privilege tables now?
EOF
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
exec "$@"
