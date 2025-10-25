#!/bin/bash

USER=ubuntu

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

$MP_CMD launch -n my-vm --cpus 2 --memory 2G --disk 10G --image 25.10
$MP_CMD transfer -r data-to-transfer/* my-vm:.
$MP_CMD exec my-vm ./../../scripts/setup-docker.sh $USER