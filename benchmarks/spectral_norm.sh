#!/bin/sh
source ./funcs.sh

measure spectral_norm.py 1 500 1.274224116 
measure spectral_norm.py 1 1000 1.274224148 
measure spectral_norm.py 1 1500 1.274224151 

measure spectral_norm.py 2 500 1.274224116 
measure spectral_norm.py 2 1000 1.274224148 
measure spectral_norm.py 2 1500 1.274224151 

measure spectral_norm.py 4 500 1.274224116 
measure spectral_norm.py 4 1000 1.274224148 
measure spectral_norm.py 4 1500 1.274224151 
