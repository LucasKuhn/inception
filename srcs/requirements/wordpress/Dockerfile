FROM debian:bullseye

# Set the environment variables to be used in the sed command below
ARG WORDPRESS_DATABASE
ARG WORDPRESS_USER
ARG WORDPRESS_PASSWORD

# Set the working directory to /var/www/html ( Where wordpress will be installed )
WORKDIR /var/www/html/

# Install php-fpm, php-mysql, mariadb-client and wget
RUN apt update -y && apt upgrade -y && apt install -y \
	php-fpm \
	php-mysql \
	mariadb-client -y \
	wget

# Replace the default PHP-FPM listen location ( which is a local socket ) with port 9000 for the php-fpm container to be able to communicate with nginx
# .default → make a backup of the original conf
# [0-9]* → glob pattern to match any php version
RUN sed -i.default "/^listen\s=.*/c\listen = 0.0.0.0:9000" \
	/etc/php/[0-9]*.[0-9]*/fpm/pool.d/www.conf

# Install Wordpress
RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xzf latest.tar.gz && \
	mv wordpress/* . && \
	rm -rf wordpress && \
	rm -rf latest.tar.gz

# Configure wordpress to use the database created in the mariadb container
RUN cp wp-config-sample.php wp-config.php && \
	sed -i "s/database_name_here/$WORDPRESS_DATABASE/g" wp-config.php && \
	sed -i "s/username_here/$WORDPRESS_USER/g" wp-config.php && \
	sed -i "s/password_here/$WORDPRESS_PASSWORD/g" wp-config.php && \
	sed -i "s/localhost/mariadb/g" wp-config.php

# Create the directory where php-fpm will store the pid file
RUN mkdir -p /run/php

# An alias to call php-fpm without specifying the version on the CMD below
RUN ln -s $(find /usr/sbin -name 'php-fpm*') /usr/bin/php-fpm

# Start php-fpm in foreground
CMD ["php-fpm", "-F"]
