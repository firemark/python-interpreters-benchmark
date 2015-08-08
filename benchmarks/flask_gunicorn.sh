#!/bin/sh
source ./funcs.sh
set -e
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT

gunicorn flask_serv:app
sleep 4
run_wrk
