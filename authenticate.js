#!/usr/bin/env node

console.log('Authentication is handled through the official qwen-code CLI tool.');
console.log('Please install the qwen-code CLI tool from: https://github.com/QwenLM/qwen-code');
console.log('Then run: qwen-code auth');
console.log('This will create the ~/.qwen/oauth_creds.json file needed by the proxy server.');
console.log('');
console.log('After authenticating, copy the credentials to the container with:');
console.log('  docker cp ~/.qwen/oauth_creds.json qwen-code-oai-proxy-qwen-proxy-1:/root/.qwen/');