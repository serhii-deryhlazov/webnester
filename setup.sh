#!/bin/bash

# Detect the OS and package manager
if command -v apk &> /dev/null; then
    # Alpine Linux
    PACKAGE_MANAGER="apk"
    SERVICE_MANAGER="rc-service"
    NGINX_CONF="/etc/nginx/nginx.conf"
    WEB_ROOT="/var/www/localhost/htdocs"
elif command -v apt &> /dev/null; then
    # Ubuntu/Debian
    PACKAGE_MANAGER="apt"
    SERVICE_MANAGER="systemctl"
    NGINX_CONF="/etc/nginx/sites-available/default"
    WEB_ROOT="/var/www/html"
else
    echo "Unsupported OS"
    exit 1
fi

# Check if nginx is installed, install if not
if ! command -v nginx &> /dev/null
then
    echo "nginx is not installed. Installing nginx..."
    if [ "$PACKAGE_MANAGER" = "apk" ]; then
        sudo apk update
        sudo apk add nginx php82 php82-fpm
    else
        sudo apt update
        sudo apt install -y nginx php-fpm
    fi
else
    echo "nginx is already installed."
fi

# Ensure SSL directory exists
SSL_DIR="/etc/nginx/ssl"
sudo mkdir -p $SSL_DIR

# Copy certificate and key files from ssh folder to SSL directory
sudo cp ssh/certificate.crt $SSL_DIR/certificate.crt
sudo cp ssh/private.key $SSL_DIR/private.key

# Create web root directory
sudo mkdir -p $WEB_ROOT

# Configure nginx for SSL
if [ "$PACKAGE_MANAGER" = "apk" ]; then
    # Alpine Linux - modify main nginx.conf
    sudo cp config/nginx-default /etc/nginx/http.d/default.conf
else
    # Ubuntu/Debian - use sites-available
    sudo cp $NGINX_CONF ${NGINX_CONF}.bak
    sudo cp config/nginx-default $NGINX_CONF
    # Enable the site by creating symlink to sites-enabled
    sudo ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
fi

# Test nginx configuration
sudo nginx -t

# Start/reload nginx
if [ "$SERVICE_MANAGER" = "rc-service" ]; then
    # Alpine Linux
    if sudo rc-service nginx status | grep -q "started"; then
        sudo rc-service nginx reload
    else
        sudo rc-service nginx start
    fi
else
    # Ubuntu/Debian
    if sudo systemctl is-active --quiet nginx; then
        sudo systemctl reload nginx
    else
        sudo systemctl start nginx
    fi
fi

echo "nginx has been configured with SSL."

sudo rm -f $WEB_ROOT/index.html
sudo cp web/index.php $WEB_ROOT/index.php

# Restart nginx to apply changes
if [ "$SERVICE_MANAGER" = "rc-service" ]; then
    # Alpine Linux
    sudo rc-service nginx restart
else
    # Ubuntu/Debian
    sudo systemctl restart nginx
fi