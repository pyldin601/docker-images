#!/usr/bin/env bash
BASH=$(which bash)

if [ -f /usr/app/startup.sh ]; then
    $BASH /usr/app/startup.sh; status=$?
    if [[ $status != 0 ]]; then
        echo "Startup script returned with error code $status"
        exit $status
    fi
fi

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
