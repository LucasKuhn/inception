# Base image for debian
FROM debian:bullseye

ARG WORDPRESS_DATABASE
ARG WORDPRESS_USER
ARG WORDPRESS_PASSWORD

# Install mariadb-server
RUN apt update -y && apt upgrade -y && apt install mariadb-server -y

# By default MariaDB is bound to localhost, it does not allow remote connections
# This setting allows remote connections from any host ( in our case, other containers )
RUN echo "[mysqld] \n\
skip-networking=0 \n\
skip-bind-address" >> /etc/mysql/my.cnf

# Copy the dump.sql file to the container
COPY ./conf/dump.sql /tmp/dump.sql

# Start the mariadb service and create a database and user for wordpress
RUN service mariadb start && \
	mariadb -u root -e \
	"CREATE DATABASE IF NOT EXISTS $WORDPRESS_DATABASE; \
	CREATE USER '$WORDPRESS_USER'@'%' identified by '$WORDPRESS_PASSWORD'; \
	GRANT ALL ON wordpress_db.* TO '$WORDPRESS_USER'@'%' IDENTIFIED BY '$WORDPRESS_PASSWORD'; \
	FLUSH PRIVILEGES;" && \
	mariadb -u root $WORDPRESS_DATABASE < /tmp/dump.sql && \
	service mariadb stop

# Start the mariadb service when the container is run
CMD ["mysqld_safe"]
