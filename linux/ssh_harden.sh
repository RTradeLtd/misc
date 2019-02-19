#! /bin/bash

# used to harden default sshd configurations

sed -i 's/AllowTcpForwarding Yes/AllowTcpForwarding No/g' /etc/ssh/sshd_config
sed -i 's/ClientAliveCount 3/ClientAliveCount 2/g' /etc/ssh/sshd_config
sed -i 's/Compression Yes/Compression No/g' /etc/ssh/sshd_config
sed -i 's/LogLevel Info/LogLevel Verbose/g' /etc/ssh/sshd_config
sed -i 's/MaxAuthTries 6/MaxAuthTries 2/g' /etc/ssh/sshd_config
sed -i 's/MaxSessions 10/MaxSessions 2/g' /etc/ssh/sshd_config
sed -i 's/TCPKeepAlive Yes/TCPKeepAlive No/g' /etc/ssh/sshd_config
sed -i 's/X11Forwarding Yes/X11Forwarding No/g' /etc/ssh/sshd_config
sed -i 's/AllowAgentForwarding Yes/AllowAgentForwarding No/g' /etc/ssh/sshd_config