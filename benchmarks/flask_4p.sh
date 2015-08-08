#!/bin/sh
source ./funcs.sh
set -e
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT

../bin/$INTERPRETER ../scripts/flask_serv_4p.py &> /dev/null&
sleep 4
run_wrk
