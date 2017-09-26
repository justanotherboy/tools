#!/bin/sh

# This script is used to detect clock skews, saving the offset to file for
# later analysis. The idea is to use ICMP Timestamps Request packet to a NTP
# Server (it should be syncrhonized) to get the differences between the two
# hosts. It is not exact but is better than nothing.

SERVER="pool.ntp.org"
LOG_FILE="/tmp/clock_skew"
# Frecuency in seconds, usually takes at least 10 seconds per run.
FRECUENCY="20"

while true; do
    now=`date +%s`
    modulo_now=$(($now % $FRECUENCY))
    if [ "$modulo_now" = "0" ]; then
        offset=`clockdiff $SERVER`
        if [ "$?" = "0" ]; then
            echo "$offset" | tr ' ' ',' >> $LOG_FILE
        else
            now=`date +%s`
            echo "$now,NA,NA" >> $LOG_FILE
        fi
    fi
    sleep 1
done
