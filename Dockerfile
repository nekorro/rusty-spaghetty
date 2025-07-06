FROM nginx:stable-alpine

ARG V2RAY_VERSION=v1.23.5
ARG SSRUST_VERSION=v1.14.3

RUN apk --no-cache add jq libqrencode
RUN mkdir -p /etc/shadowsocks /ssbin /wwwroot
RUN wget -O- https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SSRUST_VERSION}/shadowsocks-${SSRUST_VERSION}.x86_64-unknown-linux-musl.tar.xz | tar Jx -C /ssbin
RUN wget -O- https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_VERSION}.tar.gz | tar zx -C . && install v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin && rm v2ray-plugin_linux_amd64
