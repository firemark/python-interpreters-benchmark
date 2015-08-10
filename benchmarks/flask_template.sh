#!/bin/sh
source ./funcs.sh
set -e

uwsgi flask_template:app
sleep 4
run_wrk
