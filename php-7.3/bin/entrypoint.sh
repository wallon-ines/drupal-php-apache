#!/bin/bash

set -e

if [[ "$SSMTP_MAILHUB" && $SSMTP_MAILHUB && $SSMTP_HOSTNAME ]]
then
  echo "root=$SSMTP_POSTMASTER" > /etc/ssmtp/ssmtp.conf
	echo "mailhub=$SSMTP_MAILHUB" >> /etc/ssmtp/ssmtp.conf
  echo "hostname=$SSMTP_HOSTNAME" >> /etc/ssmtp/ssmtp.conf
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- apache2-foreground "$@"
fi

exec "$@"
