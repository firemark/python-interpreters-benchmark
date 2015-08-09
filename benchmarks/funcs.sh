#!/bin/sh
trap "trap - SIGTERM && kill -- -$$"  EXIT SIGINT SIGTERM SIGKILL
set -e

string_format="%C :: time %es mem %Mkb out %O in %I result %x"
function measure {
    cd ../bin 
    /usr/bin/time -f "$string_format" -o /dev/tty ./$INTERPRETER ../scripts/$@ &> tmp/log
    cd - > /dev/null
}

function uwsgi {
    echo $INTERPRETER uwsgi $1
    DIR=${2:-scripts/}
    if [[ $INTERPRETER =~ ^pypy ]]; then
        WSGIARG="--pypy-wsgi $1"
    else
        WSGIARG="-w $1"
    fi
    cd ..
    nginx -p $(pwd) -c nginx.conf&
    venvs/$INTERPRETER/bin/uwsgi \
        -s $(pwd)/tmp/uwsgi.sock \
        -m \
        --processes 4 \
        --chdir $DIR \
        $WSGIARG &> tmp/log&
    cd - > /dev/null
}

function gunicorn {
    echo $INTERPRETER gunicorn $1
    DIR=${2:-scripts/}
    cd ..
    venvs/$INTERPRETER/bin/gunicorn \
        --workers 4 \
        --chdir $DIR \
        --bind 127.0.0.1:5000 $1 &> tmp/log&
    cd - > /dev/null
}

function run_wrk {
    wrk -t8 -c100 -d30s --latency --timeout 5s http://127.0.0.1:5000/
}

