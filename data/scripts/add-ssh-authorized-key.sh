#!/bin/bash

USER_NAME=$1

 # Add your public key to authorized_keys
cat /home/${USER_NAME}/.ssh/uploaded_key.pub >> /home/${USER_NAME}/.ssh/authorized_keys

# Set correct permissions
chmod 600 /home/${USER_NAME}/.ssh/authorized_keys
chmod 700 /home/${USER_NAME}/.ssh

# Clean up the temporary file
rm /home/${USER_NAME}/.ssh/uploaded_key.pub
