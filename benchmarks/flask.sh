#!/bin/sh
source ./funcs.sh
set -e

../bin/$INTERPRETER ../scripts/flask_serv.py &> ../tmp/log&
sleep 10
run_wrk
