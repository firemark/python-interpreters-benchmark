#!/bin/sh

cd ..
function fib {
    echo $INTERPRETER $(bin/$INTERPRETER scripts/fib_with_measure.py $1 $2 2> /dev/null)
}
fib 30 832040
fib 35 9227465
fib 40 102334155
