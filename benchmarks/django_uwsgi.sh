#!/bin/sh
source ./funcs.sh
set -e

uwsgi django_serv.wsgi scripts/django_serv/
sleep 4
run_wrk
