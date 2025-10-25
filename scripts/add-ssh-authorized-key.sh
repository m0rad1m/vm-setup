#!/bin/bash

USER=$1

 # Add your public key to authorized_keys
cat /home/${USER}/.ssh/uploaded_key.pub >> /home/${USER}/.ssh/authorized_keys

# Set correct permissions
chmod 600 /home/${USER}/.ssh/authorized_keys
chmod 700 /home/${USER}/.ssh

# Clean up the temporary file
rm /home/${USER}/.ssh/uploaded_key.pub