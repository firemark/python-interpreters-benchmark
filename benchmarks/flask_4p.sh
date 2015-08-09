#!/bin/sh
source ./funcs.sh
set -e

../bin/$INTERPRETER ../scripts/flask_serv_4p.py &> ../tmp/log&
sleep 4
run_wrk
