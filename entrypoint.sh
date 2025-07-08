#!/bin/sh

echo "$UPSTREAM"

export PORT="${PORT:-"443"}"
echo "$PORT"

sh /conf/nginx_stream.conf.template >  /opt/nginx/stream.conf.d/nginx_stream.conf
echo /opt/nginx/stream.conf.d/nginx_stream.conf
cat /opt/nginx/stream.conf.d/nginx_stream.conf

/opt/nginx/sbin/nginx -g "daemon off;"
