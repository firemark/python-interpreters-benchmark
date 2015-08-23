#!/bin/sh
source ./funcs.sh
set -e

gunicorn flask_serv:app
sleep 10
run_wrk
