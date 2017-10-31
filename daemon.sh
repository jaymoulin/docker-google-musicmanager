#!/bin/sh

if [ ! -f /root/oauth/oauth.key ]; then
    trap 'exit 0' TERM INT
    while :
    do
        sleep 2
    /bin/true
    done
else
    trap 'kill -TERM $PIDU;kill -TERM $PIDD' TERM INT
    python3 /root/manager/uploader-daemon.py -d /media/library/upload -a /root/oauth/oauth.key &
    PIDU=$!
    python3 /root/manager/download.py -d /media/library/download -a /root/oauth/oauth.key &
    PIDD=$!
    wait $PIDD
    wait $PIDD
    wait $PIDU
    wait $PIDU
    EXIT_STATUS=$?
fi
