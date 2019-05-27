#!/bin/bash
/usr/sbin/sshd
run_cmd="dotnet run --server.urls http://*:80"
>&2 echo FUCKER"
exec $run_cmd
