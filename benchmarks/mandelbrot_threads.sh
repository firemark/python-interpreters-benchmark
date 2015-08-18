#!/bin/sh
source ./funcs.sh

measure mandelbrot_threads.py 1
measure mandelbrot_threads.py 2
measure mandelbrot_threads.py 4
measure mandelbrot_threads.py 8

