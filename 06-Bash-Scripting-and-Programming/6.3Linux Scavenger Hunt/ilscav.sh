#!/usr/bin/env bash

# Variables
LAB_ENV_DIR="$HOME/Documents/LabEnvironments"
SCAVENGER_DIR="$LAB_ENV_DIR/linux-scavenger"
#VAGRANTFILE_URL="https://tinyurl.com/y44dcy5t"
VAGRANTFILE_URL="file:///C:/Users/Sara/Documents/Berkeley_CS/UCB-VIRT-CYBER-PT-03-2023-U-LOLC/06/LinuxScavengerVagrantfile"

# Create Environment & Download Vagrantfile
echo "Creating $SCAVENGIR_DIR and downloading Vagrantfile..."
mkdir -p "$SCAVENGER_DIR" && cd "$_"
curl -s -L -o Vagrantfile $VAGRANTFILE_URL

# Lift Machine and Install Reprovisioner
vagrant up

# Tell Students how to Connect
SSH_USERNAME="student"
PORT=$(vagrant ssh-config | grep -i 'port' | awk '{print $2}' | sed 's/\s*//g')

echo "Your Scavenger Hunt environment has been installed to $(pwd)!"
echo -e "\nConnect via SSH by running: ssh $SSH_USERNAME@192.168.200.105"
