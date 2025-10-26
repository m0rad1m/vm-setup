#!/bin/bash

# Check if USER_NAME parameter is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <USER_NAME>"
    echo "Example: $0 newuser"
    exit 1
fi

USER_NAME=$1
SSH_DIR="/home/$USER_NAME/.ssh"

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)"
    exit 1
fi

# Check if user exists
if !id "$USER_NAME" &>/dev/null; then
    echo "Error: User '$USER_NAME' does not exists"
    exit 1
fi

# Create .ssh directory if it doesn't exist
mkdir -p "$SSH_DIR"

 # Add your public key to authorized_keys
cat ./uploaded_key.pub >> /home/${USER_NAME}/.ssh/authorized_keys

# Set correct ownership
chown -R "$USER_NAME:$USER_NAME" "$SSH_DIR"

# Set correct permissions
chmod 600 /home/${USER_NAME}/.ssh/authorized_keys
chmod 700 /home/${USER_NAME}/.ssh

# Clean up the temporary file
rm ./uploaded_key.pub
