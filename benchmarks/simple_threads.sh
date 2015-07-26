#!/bin/sh
source ./funcs.sh

measure simple_threads.py 1 800000000
measure simple_threads.py 2 800000000
measure simple_threads.py 4 800000000
measure simple_threads.py 8 800000000
