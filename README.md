# Qwen OpenAI-Compatible Proxy Server

A proxy server that exposes Qwen models through an OpenAI-compatible API endpoint.

## Important Notes

Users might face errors or 504 Gateway Timeout issues when using contexts with 130,000 to 150,000 tokens or more. This appears to be a practical limit for Qwen models. Qwen code it self tends to also break down and get stuck on this limit . 


## Quick Start

### Option 1: Running with Docker (Recommended)

1. **Prerequisites**: Docker and Docker Compose installed on your system
2. **Build and start the container**:
   ```bash
   docker-compose up -d
   ```
3. **Authenticate with Qwen**:
   ```bash
   docker-compose exec qwen-proxy npm run auth
   ```
   Follow the instructions to authenticate with your Qwen account.
4. **Use the Proxy**: Point your OpenAI-compatible client to `http://localhost:8080/v1`.

For detailed Docker instructions, see [DOCKER.md](DOCKER.md).

### Option 2: Running Directly

1.  **Prerequisites**: You need to authenticate with Qwen using the official `qwen-code` CLI tool to generate the required credentials file.
    *   Install the `qwen-code` CLI tool from [QwenLM/qwen-code](https://github.com/QwenLM/qwen-code)
    *   Run `qwen-code auth` to authenticate with your Qwen account
    *   This will create the `~/.qwen/oauth_creds.json` file needed by the proxy server
2.  **Install Dependencies**:
    ```bash
    npm install
    ```
3.  **Start the Server**:
    ```bash
    npm start
    ```
4.  **Use the Proxy**: Point your OpenAI-compatible client to `http://localhost:8080/v1`.

## Configuration

The proxy server can be configured using environment variables. Create a `.env` file in the project root or set the variables directly in your environment.

*   `LOG_FILE_LIMIT`: Maximum number of debug log files to keep (default: 20)
*   `DEBUG_LOG`: Set to `true` to enable debug logging (default: false)

Example `.env` file:
```bash
# Keep only the 10 most recent log files
LOG_FILE_LIMIT=10

# Enable debug logging (log files will be created)
DEBUG_LOG=true
```

## Example Usage

```javascript
import OpenAI from 'openai';

const openai = new OpenAI({
  apiKey: 'fake-key', // Not used, but required by the OpenAI client
  baseURL: 'http://localhost:8080/v1'
});

async function main() {
  const response = await openai.chat.completions.create({
    model: 'qwen-coder-plus',
    messages: [
      { "role": "user", "content": "Hello!" }
    ]
  });

  console.log(response.choices[0].message.content);
}

main();
```

## Supported Endpoints

*   `POST /v1/chat/completions`
*   `POST /v1/embeddings`


## Token Counting

The proxy now displays token counts in the terminal for each request, showing both input tokens and API-returned usage statistics (prompt, completion, and total tokens).

For more detailed documentation, see the `docs/` directory.
