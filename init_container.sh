#!/bin/bash
set -e
if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
  # generate fresh rsa key
  ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi
if [ ! -f "/etc/ssh/ssh_host_dsa_key" ]; then
  # generate fresh dsa key
  ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi
if [ ! -f "/etc/ssh/ssh_host_ecdsa_key" ]; then
  # generate fresh ecdsa key
  ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t dsa
fi
if [ ! -f "/etc/ssh/ssh_host_ed25519_key" ]; then
  # generate fresh ecdsa key
  ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t dsa
fi
#prepare run dir
if [ ! -d "/var/run/sshd" ]; then
  mkdir -p /var/run/sshd
fi
run_cmd="dotnet run --server.urls http://*:80"
# starting sshd process
sed -i "s/SSH_PORT/$SSH_PORT/g" /etc/ssh/sshd_config
/usr/sbin/sshd
>&2 echo "SQL Server is up - executing command"
exec $run_cmd
