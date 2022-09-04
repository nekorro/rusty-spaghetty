#!/bin/sh
cat <<EOF
{
    "server":"127.0.0.1",
    "server_port":2333,
    "password":${SS_PASSWORD_JSON},
    "timeout":300,
    "method":"${ENCRYPT}",
    "mode": "tcp_only",
    "fast_open":false,
    "reuse_port":true,
    "no_delay":true,
    "plugin": "v2ray-plugin",
    "plugin_opts":"server;path=/${V2_PATH}"
}
EOF
