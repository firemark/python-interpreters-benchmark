#!/bin/sh
set -e
cd ..
bin/$INTERPRETER scripts/chaos.py
cd - > /dev/null
