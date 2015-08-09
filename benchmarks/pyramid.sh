#!/bin/sh
source ./funcs.sh
set -e
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT

../bin/$INTERPRETER ../scripts/pyramid_serv.py &> ../tmp/log&
sleep 4
run_wrk
