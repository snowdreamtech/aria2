#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ [aria2] Starting aria2..."; fi

# openssl rand -base64 33
if [ -z "${RPC_HASH}" ]; then {
    RPC_HASH=$(openssl rand -base64 33)
    echo "Generate random aria2 rpc secret: ${RPC_HASH}"
}
fi

# aria2c
/usr/bin/aria2c --conf-path /etc/aria2.conf --daemon --enable-rpc --rpc-listen-all --rpc-secret="${RPC_HASH}"

# exec

if [ "$DEBUG" = "true" ]; then echo "→ [aria2] Aria2 started."; fi