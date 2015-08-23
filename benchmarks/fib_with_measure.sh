#!/bin/sh

cd ..
function fib {
    echo $INTERPRETER $1 $(bin/$INTERPRETER scripts/fib_with_measure.py $1 $2 2> /dev/null)
}
fib 30 832040
fib 31 1346269
fib 32 2178309
fib 33 3524578
fib 34 5702887
fib 35 9227465
fib 36 14930352
fib 37 24157817
fib 38 39088169
fib 39 63245986
fib 40 102334155
