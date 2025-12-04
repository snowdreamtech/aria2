#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ [aria2] Starting aria2..."; fi

# openssl rand -base64 33
if [ -z "${RPC_SECRET}" ]; then {
    RPC_SECRET=$(openssl rand -base64 33)
    echo "Generate random aria2 rpc secret: ${RPC_SECRET}"
}
fi

# aria2c
/usr/bin/aria2c --conf-path /etc/aria2.conf --daemon --enable-rpc --rpc-listen-all --rpc-secret="${RPC_SECRET}"


if [ "$DEBUG" = "true" ]; then echo "→ [aria2] Aria2 started."; fi