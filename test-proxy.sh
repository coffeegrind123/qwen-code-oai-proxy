#!/bin/bash

# This script tests if the Qwen proxy is running correctly

echo "Testing Qwen OpenAI-Compatible Proxy"
echo "===================================="

# Check if the proxy is running
if curl -s http://localhost:8081/health | grep -q '"status":"ok"'; then
    echo "✓ Proxy is running and healthy"
else
    echo "✗ Proxy is not responding or not healthy"
    echo "Please make sure the proxy is running with: docker-compose up -d"
    exit 1
fi

# Test the models endpoint
echo ""
echo "Testing models endpoint..."
if curl -s -X GET http://localhost:8081/v1/models | grep -q '"object":"list"'; then
    echo "✓ Models endpoint is working"
else
    echo "✗ Models endpoint is not responding correctly"
fi

echo ""
echo "Test complete!"
echo "To use the proxy with an OpenAI-compatible client, set the base URL to:"
echo "  http://localhost:8081/v1"