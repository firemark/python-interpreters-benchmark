#!/bin/sh

function measure {
    /usr/bin/time -f "%C || time %es mem %Mkb" $INTERPRETER fib.py $1 $2
}

measure 30 832040
measure 35 9227465
measure 40 102334155
