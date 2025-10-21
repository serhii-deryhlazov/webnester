#!/bin/bash

# Check if nginx is installed, install if not
if ! command -v nginx &> /dev/null
then
    echo "nginx is not installed. Installing nginx..."
    sudo apt update
    sudo apt install -y nginx
else
    echo "nginx is already installed."
fi

# Ensure SSL directory exists
SSL_DIR="/etc/nginx/ssl"
sudo mkdir -p $SSL_DIR

# Copy certificate and key files from ssh folder to SSL directory
sudo cp ssh/certificate.crt $SSL_DIR/certificate.crt
sudo cp ssh/private.key $SSL_DIR/private.key

# Backup the default site configuration
NGINX_DEFAULT="/etc/nginx/sites-available/default"
sudo cp $NGINX_DEFAULT ${NGINX_DEFAULT}.bak

# Configure nginx for SSL
sudo cp config/nginx-default $NGINX_DEFAULT

# Test nginx configuration
sudo nginx -t

# Reload nginx
sudo systemctl reload nginx

echo "nginx has been configured with SSL."

sudo rm -f /var/www/html/index.html
sudo cp web/index.php /var/www/html/index.php

# Restart nginx to apply changes
sudo systemctl restart nginx