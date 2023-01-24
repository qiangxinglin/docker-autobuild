#!/bin/sh
COMMAND=/usr/local/bin/i2pd
# To make ports exposeable
# Note: $DATA_DIR is defined in /etc/profile

if [ "$1" = "--help" ]; then
    set -- $COMMAND --help
else
    set -- $COMMAND $DEFAULT_ARGS $@
fi

exec "$@"