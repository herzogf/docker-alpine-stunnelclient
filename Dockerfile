FROM alpine:3.4
MAINTAINER Florian Herzog

COPY . /

RUN set -e && \
    echo "http://dl-3.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk add --no-cache openssl stunnel && \
    rm -rf /tmp/* /var/cache/apk/* && \
    chmod a+rx /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
