FROM alpine:3.4
MAINTAINER Florian Herzog

COPY . /

RUN set -e && \
    apk add --no-cache openssl
    wget https://www.stunnel.org/downloads/stunnel-5.37.tar.gz && \
    echo "d0e3530e3effc64fdec792c71791d4937c6b8bd3b9ea4895c6bb6526dcd0d241  stunnel-5.37.tar.gz" | sha256sum -c '-' && \
    tar -xzf stunnel-5.37.tar.gz && rm stunnel-5.37.tar.gz && mv stunnel-5.37 /usr/local/bin/stunnel && \
    rm -rf /tmp/* /var/cache/apk/* && \
    chmod a+rx /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
