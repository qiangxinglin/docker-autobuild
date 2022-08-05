#!/bin/sh

echo >&2 "       ___  _  ___            _ "
echo >&2 " _ __ / _ \/ |/ _ \ _ __   __| |"
echo >&2 "| '_ \ (_) | | | | | '_ \ / _\` |"
echo >&2 "| |_) \__, | | |_| | | | | (_| |"
echo >&2 "| .__/  /_/|_|\___/|_| |_|\__,_|"
echo >&2 "|_|                             "
echo >&2 "-----------------------------------\n\n"

if [ $# -eq 0 ]; then
    args="-f $PRINTER_DEVICE"
    if [ $BIDIRECTIONAL -eq 1 ]; then
        args="$args -b "
    fi
    if [ $DEBUG_INFO -eq 1 ]; then
        args="$args -d "
    fi
else
    args=$@
fi

exec "p910nd $args"
