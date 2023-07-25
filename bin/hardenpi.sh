#!/bin/bash

# move ssh key file over to new device
scp thinkjet-3:~/firstKeyPair.pem ~/
chmod 600 firstKeyPair.pem # enhance security

sudo apt-get update && sudo apt-get upgrade -y
# updates
sudo apt install unattended-upgrades apt-listchanges apticron -y

# ssh rules
cat <<EOF >> sshd_config
"PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
UsePAM no
X11Forwarding no
AllowGroups ssh-users"
EOF
sudo mv sshd_config /etc/ssh/sshd_config

# ssh config
cat <<EOF >> ~/.ssh/config
Host ec2
    HostName kammes.org
    User ec2-user
    Port 22
    IdentityFile ~/firstKeyPair.pem
EOF

# create autossh for tunneling
sudo echo "autossh -N -o ServerAliveInterval=20 -R 8023:127.0.0.1:22 ec2" > ~/connect.sh
cat <<EOF >> sshtunnel.service
[Unit]
Description=SSH Tunnel
After=network.target

[Service]
Restart=always
RestartSec=20
User=colton
ExecStart=/bin/sh /home/colton/connect.sh

[Install]
WantedBy=multi-user.target
EOF
echo "Don't forget to run connect.sh to verify the signature"
sudo apt install autossh -y
sudo mv sshtunnel.service /etc/systemd/system/sshtunnel.service
sudo systemctl daemon-reload
sudo systemctl enable sshtunnel

# firewall rules
sudo apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw limit ssh
sudo ufw logging on
sudo ufw enable

# clean up and apply all changes
sudo apt-get autoremove -y
sudo reboot
