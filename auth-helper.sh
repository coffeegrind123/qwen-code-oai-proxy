#!/bin/bash

# This script helps with the authentication process for the Qwen proxy

echo "Qwen OpenAI-Compatible Proxy - Authentication Helper"
echo "==================================================="

# Check if running in Docker
if [ -f /.dockerenv ]; then
    echo "This script should be run on the host machine, not inside the container."
    echo "Please run it from your host system to authenticate with Qwen."
    exit 1
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null && ! command -v "docker compose" &> /dev/null; then
    echo "docker-compose is not installed. Please install docker-compose first."
    exit 1
fi

echo ""
echo "Step 1: Building the Docker container..."
if command -v docker-compose &> /dev/null; then
    docker-compose build
else
    docker compose build
fi

echo ""
echo "Step 2: Starting the container in the background..."
if command -v docker-compose &> /dev/null; then
    docker-compose up -d
else
    docker compose up -d
fi

echo ""
echo "Step 3: Authenticating with Qwen..."
echo "To use the Qwen proxy, you need to authenticate with Qwen using the official qwen-code CLI tool."
echo ""
echo "Please follow these steps:"
echo ""
echo "1. Install the qwen-code CLI tool from: https://github.com/QwenLM/qwen-code"
echo "2. Run 'qwen-code auth' to authenticate with your Qwen account"
echo "3. Copy your credentials to the container with:"
echo ""
echo "   docker cp ~/.qwen/oauth_creds.json qwen-code-oai-proxy-qwen-proxy-1:/home/nextjs/.qwen/"
echo ""
echo "After completing these steps, your proxy will be ready to use."
echo ""
echo "To test the proxy, you can make a request to:"
echo "  curl http://localhost:8081/health"
echo ""
echo "To stop the proxy, run:"
if command -v docker-compose &> /dev/null; then
    echo "  docker-compose down"
else
    echo "  docker compose down"
fi