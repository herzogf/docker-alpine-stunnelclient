FROM alpine:3.4
MAINTAINER Florian Herzog

RUN set -e && apk update && apk add --update stunnel

RUN set -e && \
    apk update && \
    apk add --update stunnel && \
    rm -rf /tmp/* /var/cache/apk/*

ENTRYPOINT ["/opt/run-stunnel.sh"]
