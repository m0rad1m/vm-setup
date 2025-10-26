#!/bin/bash

# Check if USER_NAME parameter is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <USER_NAME>"
    exit 1
fi

USER_NAME=$1
SSH_DIR="/home/$USER_NAME/.ssh"

# Create .ssh directory if it doesn't exist
mkdir -p "$SSH_DIR"

# Set correct ownership
chown "$USER_NAME:$USER_NAME" "$SSH_DIR"

# Set correct permissions (700 for .ssh directory)
chmod 700 "$SSH_DIR"

echo "SSH directory prepared successfully for user $USER_NAME"