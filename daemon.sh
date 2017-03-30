#!/bin/bash

if [ ! -f /root/oauth/oauth.key ]; then
    trap 'exit 0' TERM INT
    while :
    do
        sleep 2
    /bin/true
    done
else
    trap 'kill -TERM $PIDU;kill -TERM $PIDD' TERM INT
    /root/upload.py /media/library /root/oauth/oauth.key &
    PIDU=$!
    /root/download.py /media/library /root/oauth/oauth.key &
    PIDD=$!
    wait $PIDD
    wait $PIDD
    wait $PIDU
    wait $PIDU
    EXIT_STATUS=$?
fi
