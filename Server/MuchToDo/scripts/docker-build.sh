#!/bin/bash
set -e

echo "Building Docker image..."
docker build -t much-to-do-api:latest .
echo "Build complete."
