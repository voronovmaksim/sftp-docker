#!/bin/bash

# Update package lists
apt-get update

# Install OpenSSH server
apt-get install -y openssh-server

# Backup the original sshd_config file
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Modify the sshd_config file
sed -i \
    -e 's/#Port 22/Port 22/' \
    -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' \
    /etc/ssh/sshd_config

# Restart the SSH server to apply changes
/etc/init.d/ssh restart

# Set root password
echo 'root:root' | chpasswd

# Display status
echo "OpenSSH has been installed and configured for SFTP as root."
