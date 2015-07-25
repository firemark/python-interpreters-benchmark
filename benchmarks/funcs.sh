#!/bin/sh
set -e

string_format="%C :: time %es mem %Mkb out %O in %I result %x"
function measure {
    /usr/bin/time -f "$string_format" -o /dev/tty $INTERPRETER ../scripts/$@ 2>/dev/null
}
