#!/bin/bash

apt-get update

apt-get install -y openssh-server

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

sed -i \
    -e 's/#Port 22/Port 22/' \
    -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' \
    /etc/ssh/sshd_config

/etc/init.d/ssh restart

echo 'root:root' | chpasswd

echo "OpenSSH has been installed and configured for SFTP as root."
