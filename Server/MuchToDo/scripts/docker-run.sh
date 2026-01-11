#!/bin/bash
set -e

echo "Starting Docker Compose environment..."
if [ -z "$JWT_SECRET_KEY" ]; then
    echo "Warning: JWT_SECRET_KEY is not set. Using default."
    export JWT_SECRET_KEY="your-super-secret-key-that-is-long-and-random"
fi

docker-compose up -d --build
echo "Environment started."
