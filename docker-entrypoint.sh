#!/bin/sh
set -e

# Nginx and AriaNg
/usr/sbin/nginx -c /etc/nginx/nginx.conf

# aria2c
/usr/bin/aria2c --conf-path /etc/aria2.conf

# exec commands
exec "$@"