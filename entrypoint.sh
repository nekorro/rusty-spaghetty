#!/bin/sh

if [[ -z "${SS_PASSWORD}" ]]; then
  export PASSWORD="5c301bb8-6c77-41a0-a606-4ba11bbab084"
fi
echo ${SS_PASSWORD}

export SS_PASSWORD_JSON="$(echo -n "$SS_PASSWORD" | jq -Rc)"

if [[ -z "${ENCRYPT}" ]]; then
  export ENCRYPT="chacha20-ietf-poly1305"
fi
echo ${ENCRYPT}

if [[ -z "${V2_PATH}" ]]; then
  export V2_PATH="s233"
fi
echo ${V2_PATH}

if [[ -z "${DOMAIN}" ]]; then
  export DOMAIN="unknown.domain.null"
fi
echo ${DOMAIN}

sh /conf/shadowsocks_config.tpl >  /etc/shadowsocks/config.json
echo /etc/shadowsocks/config.json
cat /etc/shadowsocks/config.json

rm -f /etc/nginx/conf.d/*
sh /conf/nginx_ss.tpl > /etc/nginx/conf.d/ss.conf
echo /etc/nginx/conf.d/ss.conf
cat /etc/nginx/conf.d/ss.conf

plugin=$(echo -n "v2ray;path=/${V2_PATH};host=${DOMAIN};tls" | sed -e 's/\//%2F/g' -e 's/=/%3D/g' -e 's/;/%3B/g')
ss="ss://$(echo -n ${ENCRYPT}:${SS_PASSWORD} | base64 -w 0)@${DOMAIN}:443?plugin=${plugin}"
echo -n "${ss}"
echo -n "${ss}" | qrencode -t ansiutf8

if [[ ! -z "${QR_PATH}" ]]; then
  echo "Generating QR-code png"
  echo ${QR_PATH}
  [ ! -d /wwwroot/${QR_PATH} ] && mkdir /wwwroot/${QR_PATH}
  echo "${ss}" | tr -d '\n' > /wwwroot/${QR_PATH}/index.html
  echo -n "${ss}" | qrencode -s 6 -o /wwwroot/${QR_PATH}/vpn.png
  ls -lah /wwwroot/${QR_PATH}/vpn.png
else
  echo "Do not generate QR-code png"
fi

/ssbin/ssserver -c /etc/shadowsocks/config.json &
/docker-entrypoint.sh
