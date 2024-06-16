#!/bin/sh
set -e

# aria2c
/usr/bin/aria2c --conf-path /etc/aria2.conf

# Nginx and AriaNg
/usr/sbin/nginx -g  "daemon off;" -c /etc/nginx/nginx.conf

# exec commands
exec "$@"