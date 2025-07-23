#!/bin/bash
set -e

# Read secrets from Docker secrets files if they exist
#if [ -f /run/secrets/wp_admin_pass ]; then
#  WP_ADMIN_PASS=$(cat /run/secrets/wp_admin_pass)
#fi
#if [ -f /run/secrets/db_password ]; then
#  WORDPRESS_DB_PASSWORD=$(cat /run/secrets/db_password)
#fi

# Wait for MariaDB to be ready
until mysql -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e ""; do
  echo "Waiting for database..."
  sleep 2
done

cd /var/www/html

# Restrict forbidden admin usernames !!!
if [[ "$WP_ADMIN_USER" =~ [Aa]dmin|[Aa]dministrator ]]; then
  echo "Error: The admin username ('$WP_ADMIN_USER') must not contain 'admin', 'Admin', 'administrator', or 'Administrator'."
  exit 1
fi

# Install WordPress if not already installed
if ! wp core is-installed --allow-root; then
  wp core install --url="$WORDPRESS_URL" --title="My Site" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASS" --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root

  # Create second user
  wp user create "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASS" --role=author --allow-root
fi

# Start php-fpm
exec php-fpm7.4 -F
