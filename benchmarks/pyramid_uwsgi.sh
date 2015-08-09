#!/bin/sh
source ./funcs.sh
set -e
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT

uwsgi pyramid_serv:app
sleep 4
run_wrk
