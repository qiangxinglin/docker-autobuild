#!/bin/bash
echo "                   _     _  _              _ _            _   "
echo "   __ _  ___ _ __ | |__ | || |         ___| (_) ___ _ __ | |_ "
echo "  / _\` |/ _ \ '_ \| '_ \| || |_ _____ / __| | |/ _ \ '_ \| __|"
echo " | (_| |  __/ |_) | | | |__   _|_____| (__| | |  __/ | | | |_ "
echo "  \__, |\___| .__/|_| |_|  |_|        \___|_|_|\___|_| |_|\__|"
echo "  |___/     |_|                                               "


if [ -z "$USERNAME" ]; then
    echo >&2 "USERNAME not set!"
    exit
fi

if [ -z "$PASSWORD" ]; then
    echo >&2 "PASSWORD not set!"
    exit
fi

echo -e "\n---------------------\n"


/usr/bin/geph4-client sync \
  --credential-cache /config \
  --username $USERNAME \
  --password $PASSWORD \
  | jq 


echo -e "\n---------------------\n"

cmd="/usr/bin/geph4-client connect "
cmd+="--credential-cache /config "
cmd+="--username $USERNAME "
cmd+="--password $PASSWORD "
cmd+="--stats-listen 0.0.0.0:9809 "
cmd+="--socks5-listen 0.0.0.0:9909 "
cmd+="--http-listen 0.0.0.0:9910 "
cmd+="--dns-listen 0.0.0.0:15353 "


$EXCLUDE_PRC && cmd+="--exclude-prc "
$STICKY_BRIDGES && cmd+="--sticky-bridges "
$USE_BRIDGES && cmd+="--use-bridges "
$USE_TCP && cmd+="--use-tcp "

[ -z "$EXIT_SERVER" ] || cmd+="--exit-server $EXIT_SERVER "
[ -z "$TCP_SHARD_COUNT" ] || cmd+="--tcp-shard-count $TCP_SHARD_COUNT "
[ -z "$TCP_SHARD_LIFETIME" ] || cmd+="--tcp-shard-lifetime $TCP_SHARD_LIFETIME "
[ -z "$UDP_SHARD_COUNT" ] || cmd+="--udp-shard-count $UDP_SHARD_COUNT "
[ -z "$UDP_SHARD_LIFETIME" ] || cmd+="--udp-shard-lifetime $UDP_SHARD_LIFETIME "
[ -z "$EXTRA_PARAMS" ] || cmd+="$EXTRA_PARAMS"

echo -n "$cmd"

echo -e "\n\n---------------------\n"

eval "$cmd"