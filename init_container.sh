#!/bin/bash
sed -i 's/SSH_PORT/2222' /etc/ssh/sshd_config
/usr/sbin/sshd
run_cmd="dotnet run --server.urls http://*:80"
>&2 echo FUCKER"
exec $run_cmd
