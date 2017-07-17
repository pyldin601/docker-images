#!/usr/bin/env bash
BASH=$(which bash)
WD=$PWD

if [ -f /usr/app/startup.sh ]; then
    cd /usr/app/
    $BASH startup.sh
    status=$?
    cd $PWD
    if [[ $status != 0 ]]; then
        echo "Startup script returned with error code $status"
        exit $status
    fi
fi

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
