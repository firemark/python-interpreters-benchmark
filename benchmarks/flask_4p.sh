#!/bin/sh
set -e
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT

../bin/$INTERPRETER ../scripts/flask_serv_4p.py &> /dev/null&
sleep 4
wrk -t8 -c100 -d30s --latency --timeout 2s http://127.0.0.1:5000/
