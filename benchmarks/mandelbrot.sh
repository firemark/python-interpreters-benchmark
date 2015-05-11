#!/bin/sh
source ./funcs.sh

WIDTH=1600
HEIGHT=1200

measure mandelbrot.py $WIDTH $HEIGHT 32
measure mandelbrot.py $WIDTH $HEIGHT 64
measure mandelbrot.py $WIDTH $HEIGHT 128

