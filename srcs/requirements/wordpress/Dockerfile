#For wordpress → install WordPress, connect to DB, configure wp-config.php.

FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y php-fpm php-mysql wget tar less && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and extract WordPress
RUN mkdir -p /var/www/html && \
    wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
    rm /tmp/wordpress.tar.gz

# Set permissions
#Add WP-CLI and a startup script:
RUN chown -R www-data:www-data /var/www/html

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose php-fpm port
EXPOSE 9000

# Start php-fpm
CMD ["php-fpm7.4", "-F"]

#Note: If the latest php-fpm version in bullseye is not 7.4, adjust the version accordingly (e.g., php-fpm8.1).