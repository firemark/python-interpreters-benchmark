#!/bin/sh
source ./funcs.sh
set -e

gunicorn flask_serv:app
sleep 4
run_wrk
