#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)"
    exit 1
fi

# Create sshd config directory if it doesn't exist
mkdir -p /etc/ssh/sshd_config.d

# Write public key authentication config directly
cat > /etc/ssh/sshd_config.d/00-only-public-key-auth.conf << 'EOL'
# Disable password based authentication on ssh servers
# Only allow public key based authentication
PasswordAuthentication no
KbdInteractiveAuthentication no
UsePAM no
EOL

# Copy hardening configuration file using cat to handle permissions correctly
cat > /etc/ssh/sshd_config.d/01-sshd-hardening.conf << 'EOL'
# SSHD Hardening Configuration
PermitRootLogin no
Protocol 2
LogLevel VERBOSE
X11Forwarding no
AllowTcpForwarding no
EOL

# Set correct permissions
chmod 644 /etc/ssh/sshd_config.d/00-only-public-key-auth.conf
chmod 644 /etc/ssh/sshd_config.d/01-sshd-hardening.conf

echo "SSH configuration files installed successfully"