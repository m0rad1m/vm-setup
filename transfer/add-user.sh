#!/bin/bash

# Creates a new user, if not already existing, and sets up password and groups.

# Check if USER_NAME parameter is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <USER_NAME>"
    echo "Example: $0 newuser"
    exit 1
fi

USER_NAME=$1
USER_PASSWORD=$USER_NAME

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)"
    exit 1
fi

# Check if USER_NAME is valid (alphanumeric and underscores only)
if ! [[ $USER_NAME =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "Error: USER_NAME must contain only letters, numbers, and underscores"
    exit 1
fi

# Check if user already exists
if id "$USER_NAME" &>/dev/null; then
    echo "Error: User '$USER_NAME' already exists"
    exit 1
fi

# Create user with home directory
if useradd -m -s /bin/bash "$USER_NAME"; then
    echo "User '$USER_NAME' created successfully"
    echo "Home directory created at /home/$USER_NAME"
    
    # Set the user's password
    echo "$USER_NAME:$USER_PASSWORD" | chpasswd
    if [ $? -eq 0 ]; then
        echo "Password set successfully"
        
        # Add user to additional groups
        if usermod -aG adm,cdrom,sudo,dip,lxd "$USER_NAME"; then
            echo "User added to supplementary groups (adm, cdrom, sudo, dip, lxd) successfully"
        else
            echo "Error: Failed to add user to supplementary groups"
            exit 1
        fi
        
        # Show the new user's details
        echo -e "\nUser details:"
        id "$USER_NAME"
    else
        echo "Error: Failed to set password for user '$USER_NAME'"
        exit 1
    fi
else
    echo "Error: Failed to create user '$USER_NAME'"
    exit 1
fi
