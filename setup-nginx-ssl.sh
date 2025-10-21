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
sudo bash -c 'cat > $NGINX_DEFAULT <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    listen 443 ssl default_server;
    listen [::]:443 ssl default_server;

    ssl_certificate /etc/nginx/ssl/certificate.crt;
    ssl_certificate_key /etc/nginx/ssl/private.key;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF'

# Test nginx configuration
sudo nginx -t

# Reload nginx
sudo systemctl reload nginx

echo "nginx has been configured with SSL."