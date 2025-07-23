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
RUN chown -R www-data:www-data /var/www/html

# Expose php-fpm port
EXPOSE 9000

# Start php-fpm
CMD ["php-fpm7.4", "-F"]

#Note: If the latest php-fpm version in bullseye is not 7.4, adjust the version accordingly (e.g., php-fpm8.1).