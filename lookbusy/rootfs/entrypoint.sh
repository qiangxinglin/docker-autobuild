#!/bin/sh

echo "  _             _    _                     "
echo " | | ___   ___ | | __ |__  _   _ ___ _   _ "
echo " | |/ _ \ / _ \| |/ / '_ \| | | / __| | | |"
echo " | | (_) | (_) |   <| |_) | |_| \__ \ |_| |"
echo " |_|\___/ \___/|_|\_\_.__/ \__,_|___/\__, |"
echo "                                     |___/ "

cmd="/usr/bin/lookbusy"
ORACLE_CPU_UTIL=10
ORACLE_MEM_UTIL=10
SPEEDTEST_SLEEP=7200
IS_ARM=$( [ $(uname -m) == "aarch64" ] && echo true || echo false )
HOST_MEM=$(expr $(grep MemTotal /proc/meminfo | tr -dc "0-9") / 1024)
HOST_MEM_UTIL=$(expr $HOST_MEM / 100 \* $ORACLE_MEM_UTIL)

if [ -n "${IS_ORACLE+set}" ]; then
    echo "Oracle settings will be applied."
    echo "Host memory is $HOST_MEM MB total."
    echo "Every 2hrs execute speedtest."
    cmd="$cmd -c $ORACLE_CPU_UTIL "
    $IS_ARM && cmd="$cmd -m "$HOST_MEM_UTIL"MB -M 100" 
else
    cmd="$cmd $1" 
fi 

echo $cmd
echo -e "\n---------------------\n"

if [ -n "${IS_ORACLE+set}" ]; then
    eval "$cmd" &
    while true; do
        /usr/bin/speedtest
        sleep $SPEEDTEST_SLEEP
        echo 
    done
else
    eval "$cmd"
fi



