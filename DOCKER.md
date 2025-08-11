# Qwen OpenAI-Compatible Proxy - Docker Setup

This document explains how to run the Qwen OpenAI-Compatible Proxy in a Docker container.

## Prerequisites

1. Docker installed on your system
2. Docker Compose installed on your system
3. Access to Qwen models through the official Qwen platform

## Quick Start

1. **Build and start the container:**
   ```bash
   docker-compose up -d
   ```

2. **Authenticate with Qwen (outside Docker):**
   You need to authenticate with Qwen using the official `qwen-code` CLI tool to generate the required credentials file.
   
   - Install the `qwen-code` CLI tool from [QwenLM/qwen-code](https://github.com/QwenLM/qwen-code)
   - Run `qwen-code auth` to authenticate with your Qwen account
   - This will create the `~/.qwen/oauth_creds.json` file needed by the proxy server

3. **Copy credentials to the container:**
   ```bash
   # Create the .qwen directory in the container
   docker-compose exec qwen-proxy mkdir -p /root/.qwen
   
   # Copy your credentials to the container
   docker cp ~/.qwen/oauth_creds.json qwen-code-oai-proxy-qwen-proxy-1:/root/.qwen/
   ```

4. **Test the proxy:**
   ```bash
   curl http://localhost:8081/health
   ```

## Using the Helper Scripts

We've provided helper scripts to make the process easier:

1. **Authentication Helper:**
   ```bash
   ./auth-helper.sh
   ```
   
   This script will:
   - Build the Docker container
   - Start it in the background
   - Provide instructions for authentication

2. **Test Script:**
   ```bash
   ./test-proxy.sh
   ```
   
   This script will verify that the proxy is running correctly.

## Configuration

You can configure the proxy using environment variables in the `docker-compose.yml` file:

- `PORT`: The port the proxy listens on (default: 8080)
- `HOST`: The host the proxy binds to (default: localhost)
- `DEBUG_LOG`: Enable debug logging (default: false)
- `LOG_FILE_LIMIT`: Maximum number of debug log files to keep (default: 20)

## Using the Proxy

Once the proxy is running and authenticated, you can use it with any OpenAI-compatible client by setting the base URL to:

```
http://localhost:8081/v1
```

Note that we're using port 8081 instead of 8080 because port 8080 was already in use on the host system.

Example using Python:
```python
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:8081/v1",
    api_key="fake-key"  # Not used, but required by the OpenAI client
)

response = client.chat.completions.create(
    model="qwen3-coder-plus",
    messages=[
        {"role": "user", "content": "Hello!"}
    ]
)

print(response.choices[0].message.content)
```

## Stopping the Proxy

To stop the proxy:
```bash
docker-compose down
```

## Managing Credentials

The Qwen credentials are stored in a Docker volume named `qwen-code-oai-proxy_qwen-credentials`. This volume persists even when the container is removed, so you won't need to re-authenticate every time you restart the container.

To view the credentials volume:
```bash
docker volume ls | grep qwen-credentials
```

To remove the credentials (forcing re-authentication):
```bash
docker-compose down -v
```