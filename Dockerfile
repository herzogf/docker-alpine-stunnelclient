FROM alpine:3.4
MAINTAINER Florian Herzog

COPY . /

RUN set -e && \
    apk add --no-cache openssl stunnel && \
    rm -rf /tmp/* /var/cache/apk/* && \
    chmod a+rx /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
