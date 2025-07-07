#!/bin/sh

ls -lah /ssbin

export SS_PASSWORD=${SS_PASSWORD:-"5c301bb8-6c77-41a0-a606-4ba11bbab084"}
echo ${SS_PASSWORD}
export SS_PASSWORD_JSON="$(echo -n "$SS_PASSWORD" | jq -Rc)"

export ENCRYPT=${ENCRYPT:-"chacha20-ietf-poly1305"}
echo ${ENCRYPT}

export V2_PATH=${V2_PATH:-"s233"}
echo ${V2_PATH}

export DOMAIN=${DOMAIN:-"unknown.domain.null"}
echo ${DOMAIN}

export PORT=${PORT:-"443"}
echo ${PORT}

export QR_PATH=${QR_PATH:-"qwe"}

export NGINX_ENTRYPOINT_WORKER_PROCESSES_AUTOTUNE="yes please"

plugin=$(echo -n "v2ray;path=/${V2_PATH};host=${DOMAIN};tls" | sed -e 's/\//%2F/g' -e 's/=/%3D/g' -e 's/;/%3B/g')
ss="ss://$(echo -n ${ENCRYPT}:${SS_PASSWORD} | base64 -w 0)@${DOMAIN}:${PORT}?plugin=${plugin}"
echo "${ss}"
echo "${ss}" | qrencode -t ansiutf8

if [[ ! -z "${QR_PATH}" ]]; then
  echo "Generating QR-code png"
  echo ${QR_PATH}
  [ ! -d /wwwroot/${QR_PATH} ] && mkdir /wwwroot/${QR_PATH}
  echo "${ss}" | tr -d '\n' > /wwwroot/${QR_PATH}/index.html
  echo -n "${ss}" | qrencode -s 6 -o /wwwroot/${QR_PATH}/vpn.png
  ls -lah /wwwroot/${QR_PATH}/vpn.png
  export QR_LOCATION="include /etc/nginx/conf.d/nginx_qr.inc;"
else
  echo "No QR-code png"
  export QR_LOCATION=""
fi

sh /conf/shadowsocks.conf.template >  /etc/shadowsocks/config.json
echo /etc/shadowsocks/config.json
cat /etc/shadowsocks/config.json

rm -f /etc/nginx/conf.d/* && mkdir -p /etc/nginx/templates/ && mv /conf/nginx*.template /etc/nginx/templates/

echo "SS SERVER RUN"
/ssbin/ssserver -c /etc/shadowsocks/config.json &
echo "NGINX RUN"
/docker-entrypoint.sh nginx -g 'daemon off;'
