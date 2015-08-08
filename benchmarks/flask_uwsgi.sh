#!/bin/sh
source ./funcs.sh
set -e
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT

uwsgi flask_serv:app
sleep 4
wrk -t8 -c100 -d30s --latency --timeout 2s http://127.0.0.1:5000/
