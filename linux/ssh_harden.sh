#! /bin/bash

# used to harden default sshd configurations


# remove comments and change settings
sudo sed -i 's/AllowTcpForwarding yes/AllowTcpForwarding no/g' /etc/ssh/sshd_config
sudo sed -i 's/ClientAliveCountMax 3/ClientAliveCountMax 2/g' /etc/ssh/sshd_config
sudo sed -i 's/Compression yes/Compression no/g' /etc/ssh/sshd_config
sudo sed -i 's/LogLevel INFO/LogLevel VERBOSE/g' /etc/ssh/sshd_config
sudo sed -i 's/MaxAuthTries 6/MaxAuthTries 2/g' /etc/ssh/sshd_config
sudo sed -i 's/MaxSessions 10/MaxSessions 2/g' /etc/ssh/sshd_config
sudo sed -i 's/TCPKeepAlive yes/TCPKeepAlive no/g' /etc/ssh/sshd_config
sudo sed -i 's/X11Forwarding yes/X11Forwarding no/g' /etc/ssh/sshd_config
sudo sed -i 's/AllowAgentForwarding yes/AllowAgentForwarding no/g' /etc/ssh/sshd_config

# remove comments
sudo sed -i 's/#AllowTcpForwarding/AllowTcpForwarding/g' /etc/ssh/sshd_config
sudo sed -i 's/#ClientAliveCountMax/ClientAliveCountMax/g' /etc/ssh/sshd_config
sudo sed -i 's/#Compression/Compression/g' /etc/ssh/sshd_config
sudo sed -i 's/#LogLevel/LogLevel/g' /etc/ssh/sshd_config
sudo sed -i 's/#MaxAuthTries/MaxAuthTries/g' /etc/ssh/sshd_config
sudo sed -i 's/#MaxSessions/MaxSessions/g' /etc/ssh/sshd_config
sudo sed -i 's/#TCPKeepAlive/TCPKeepAlive/g' /etc/ssh/sshd_config
sudo sed -i 's/#X11Forwarding/X11Forwarding/g' /etc/ssh/sshd_config
sudo sed -i 's/#AllowAgentForwarding/AllowAgentForwarding/g' /etc/ssh/sshd_config

echo "[INFO] please manually change password authentication, pubkey authentication, and permit root login"