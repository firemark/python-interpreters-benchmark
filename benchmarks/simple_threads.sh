#!/bin/sh
source ./funcs.sh

measure simple_threads.py 1 100000000
measure simple_threads.py 2 100000000
measure simple_threads.py 4 100000000
measure simple_threads.py 8 100000000

measure simple_threads.py 1 200000000
measure simple_threads.py 2 200000000
measure simple_threads.py 4 200000000
measure simple_threads.py 8 200000000

measure simple_threads.py 1 400000000
measure simple_threads.py 2 400000000
measure simple_threads.py 4 400000000
measure simple_threads.py 8 400000000
