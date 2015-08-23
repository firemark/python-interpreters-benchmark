#!/bin/sh
#!
source ./funcs.sh
set -e

../bin/$INTERPRETER ../scripts/django_serv/manage.py \
    runserver 0:5000 \
    --noreload &> ../tmp/log &
sleep 9
run_wrk
