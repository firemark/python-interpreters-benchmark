#!/bin/sh
set -e

string_format="%C :: time %es mem %Mkb out %O in %I result %x"
function measure {
    cd ../bin 
    /usr/bin/time -f "$string_format" -o /dev/tty ./$INTERPRETER ../scripts/$@ 2>/dev/null
    cd - > /dev/null
}

function uwsgi {
    if [[ $INTERPRETER =~ ^pypy ]]; then
        WSGIARG="--pypy-wsgi $1"
    else
        WSGIARG="-w $1"
    fi
    cd ..
    nginx -p $(pwd) -c nginx.conf&
    venvs/$INTERPRETER/bin/uwsgi \
        -s ../tmp/uwsgi.sock \
        --processes 4 \
        --chdir scripts/ \
        $WSGIARG &> /dev/null&
    cd - > /dev/null
}
