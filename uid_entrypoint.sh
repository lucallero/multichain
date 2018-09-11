#!/bin/sh
if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER}:x:$(id -u):0:${USER} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi
exec "$@"
