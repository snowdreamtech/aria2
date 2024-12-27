#!/bin/sh
set -e

# openssl rand -base64 33
if [ -z "${RPC_SECRET}" ]; then {
    RPC_SECRET=$(openssl rand -base64 33)
    echo "Generate random aria2 rpc secret: ${RPC_SECRET}"
}
fi

# aria2c
/usr/bin/aria2c --conf-path /etc/aria2.conf --daemon --enable-rpc --rpc-listen-all --rpc-secret="${RPC_SECRET}"

# exec commands
if [ -n "$*" ]; then
    sh -c "$*"
fi

# keep the docker container running
# https://github.com/docker/compose/issues/1926#issuecomment-422351028
if [ "${KEEPALIVE}" -eq 1 ]; then
    trap : TERM INT
    tail -f /dev/null & wait
    # sleep infinity & wait
fi