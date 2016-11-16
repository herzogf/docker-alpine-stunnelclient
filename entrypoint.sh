#!/bin/sh

#fail fast
set -e

if [[ -z "$LOCAL_PORT" || -z "$TARGET_ADDRESS" ]] ; then
  echo "Required env variables LOCAL_PORT and/or TARGET_ADDRESS missing"
  exit 1
fi

#set default verify level 4 ("Ignore the chain and only verify the peer certificate.")
#see https://www.stunnel.org/static/stunnel.html
: VERIFY_LEVEL=${VERIFY_LEVEL:4}

: DEBUG_LEVEL=${DEBUG_LEVEL:warning}

cat << EOF > /etc/stunnel/plainToTLS.conf
foreground = yes
syslog = no
debug = ${DEBUG_LEVEL}
options = NO_SSLv2

[plainToTLS]
client = yes
accept = ${LOCAL_PORT}
connect = ${TARGET_ADDRESS}
verify = ${VERIFY_LEVEL}
EOF

if [ ! -z "${CA_FILE}" ] ; then
  echo "CAfile = ${CA_FILE}" >> /etc/stunnel/plainToTLS.conf
fi

exec /usr/bin/stunnel /etc/stunnel/plainToTLS.conf
