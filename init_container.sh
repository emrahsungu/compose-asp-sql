#!/bin/bash
run_cmd="dotnet run --server.urls http://*:80"
# starting sshd process
sed -i "s/SSH_PORT/$SSH_PORT/g"
/usr/sbin/sshd
/etc/ssh/sshd
>&2 echo "SQL Server is up - executing command"
exec $run_cmd
