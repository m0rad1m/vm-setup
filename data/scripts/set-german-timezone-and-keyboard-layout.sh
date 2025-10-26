#!/bin/bash

echo "# Setting the timezone to 'Europe/Berlin'"
echo "---"

# Set timezone to Europe/Berlin
timedatectl set-timezone Europe/Berlin

echo "# Changing keyboard layout to German"
echo "---"

# Set the keyboard layout to German for the current session
sudo loadkeys de

# Make the change persistent across reboots
# Update keyboard configuration file
sudo tee /etc/default/keyboard > /dev/null <<EOF
XKBMODEL="pc105"
XKBLAYOUT="de"
XKBVARIANT=""
XKBOPTIONS=""
BACKSPACE="guess"
EOF

# Apply the keyboard configuration
sudo setupcon -k

echo "Keyboard layout changed to German (de)."
echo "The change will persist after reboot."