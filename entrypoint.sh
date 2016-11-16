#!/bin/sh

#fail fast
set -e

if [[ -z "$LOCAL_PORT" || -z "$TARGET_ADDRESS" ]] ; then
  echo "Required env variables LOCAL_PORT and/or TARGET_ADDRESS missing"
  exit 1
fi
