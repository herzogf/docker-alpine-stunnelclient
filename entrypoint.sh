#!/bin/sh

#fail fast
set -e

if [[ -z "$LOCAL_PORT" || -z "$TARGET_ADDRESS" ]] ; then
  echo "Required env variables LOCAL_PORT and/or TARGET_ADDRESS missing"
  exit 1
fi

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

EOF

if [ ! -z "${CA_FILE}" ] ; then
  echo "CAfile = ${CA_FILE}" >> /etc/stunnel/plainToTLS.conf
fi

#no verify means ignoring all server/client certs
#see https://www.stunnel.org/static/stunnel.html
if [ -z "$VERIFY_LEVEL" ] ; then
  echo "verify = ${VERIFY_LEVEL}" >> /etc/stunnel/plainToTLS.conf
fi

exec /usr/bin/stunnel /etc/stunnel/plainToTLS.conf
