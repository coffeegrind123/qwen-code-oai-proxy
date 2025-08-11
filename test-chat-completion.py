#!/usr/bin/env python3

import requests
import json

def test_chat_completion():
    # Test the chat completion endpoint
    print("Testing Qwen OpenAI-Compatible Proxy")
    print("=" * 40)
    
    # Make a request to the proxy
    url = "http://host.docker.internal:8081/v1/chat/completions"
    payload = {
        "model": "qwen3-coder-plus",
        "messages": [
            {"role": "user", "content": "Hello, world!"}
        ],
        "temperature": 0.7
    }
    
    headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer fake-key"  # Not used, but required by the OpenAI client
    }
    
    try:
        response = requests.post(url, json=payload, headers=headers, timeout=30)
        print(f"Status Code: {response.status_code}")
        print(f"Response: {response.text}")
        
        if response.status_code == 200:
            print("\n\u2713 Chat completion request successful!")
        else:
            print("\n\u2717 Chat completion request failed.")
            print("This is expected if the credentials are not valid or if you don't have access to the Qwen API.")
            
    except requests.exceptions.Timeout:
        print("\u2717 Request timed out.")
    except Exception as e:
        print(f"\u2717 Error making request: {str(e)}")

if __name__ == "__main__":
    test_chat_completion()