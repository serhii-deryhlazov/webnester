FROM alpine:3.18

# Install minimal required packages
RUN apk add --no-cache \
    bash \
    git \
    nginx \
    php82 \
    php82-fpm \
    openssl \
    nano \
    sudo

# Create a non-root user
RUN adduser -D -s /bin/bash testuser && \
    echo 'testuser ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Set working directory
WORKDIR /home/testuser

# Switch to non-root user
USER testuser

# Expose ports
EXPOSE 80 443

CMD ["/bin/bash"]
