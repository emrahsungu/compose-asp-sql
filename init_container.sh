#!/bin/bash
com ="/etc/init.d/ssh start"
exec $com
run_cmd="dotnet run --server.urls http://*:80"
>&2 echo "FUCKER"
exec $run_cmd
