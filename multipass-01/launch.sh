#!/bin/bash

# Check which Multipass command to use
# multipass (Linux/Mac) or multipass.exe (Windows)
if command -v multipass >/dev/null 2>&1; then
    MP_CMD="multipass"
elif command -v multipass.exe >/dev/null 2>&1; then
    MP_CMD="multipass.exe"
else
    echo "Error: Neither multipass nor multipass.exe found in PATH"
    exit 1
fi

###################################
### Virtual machine settings
###################################

# Network settings
NETWORK_NAME="eth0"  # Change this to your network interface name
IP_ADDRESS="192.168.50.99"  # Change this to your desired IP address

# Launch the VM with specified resources and network configuration
$MP_CMD launch \
    --cpus 2 \
    --memory 2G \
    --disk 10G \
    --name my-docker-vm \
    25.10


# Get the absolute path to the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Transfer data files to the VM
$MP_CMD transfer -r -p "${SCRIPT_DIR}/../transfer/"* my-docker-vm:.

# Install Ansible
$MP_CMD exec my-docker-vm -- sudo apt-get update
$MP_CMD exec my-docker-vm -- sudo apt-get install -y ansible

# Execute provisioning script inside the VM
$MP_CMD exec my-docker-vm sudo ./provision.sh



echo "VM 'my-docker-vm' launched and provisioned successfully."