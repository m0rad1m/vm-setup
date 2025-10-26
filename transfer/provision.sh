#!/bin/bash

USER_NAME="ansible"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Execute add-user script
echo "Creating user: $USER_NAME"
"$SCRIPT_DIR/add-user.sh" "$USER_NAME"

# Check if add-user was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to add user"
    exit 1
fi

# Execute add-ssh-authorized-key script
echo "Adding SSH authorized key for user: $USER_NAME"
"$SCRIPT_DIR/add-ssh-authorized-key.sh" "$USER_NAME" "./uploaded_key.pub"

# Check if add-ssh-authorized-key was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to add SSH authorized key"
    exit 1
fi

echo "Provisioning completed successfully for user: $USER_NAME"
