#!/bin/bash

# Build the Docker image
echo "Building webnester-test Docker image..."
docker build -t webnester-test dockerfile/

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Docker image built successfully!"
    echo "🚀 Starting container..."
    
    # Run the container with port mapping
    docker run -it --rm -p 80:80 -p 443:443 webnester-test
else
    echo "❌ Docker build failed!"
    exit 1
fi
