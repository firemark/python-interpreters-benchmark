#!/bin/sh
source ./funcs.sh
set -e

uwsgi flask_serv:app
sleep 4
run_wrk
