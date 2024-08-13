#!/bin/bash

show_usage() {
    echo -e "Usage: $0 [HOST] [VHOST] [USERNAME]"
    echo ""
}

if [ "$#" -ne 3 ]
then
    show_usage
    exit 1
fi

HOST=$1
VHOST=$2
USERNAME=$3
ROOT=$(pwd)

# load config or exit
CONFIGFILE="${ROOT}/config/${HOST}.cfg"
if [ ! -f $CONFIGFILE ];
then
   echo "File $CONFIGFILE does not exist. Exiting..."
   exit 1
fi

source $CONFIGFILE

# /api/permissions/vhost/user
curl -i \
      -u ${RABBITMQ_USER}:${RABBITMQ_PASS} \
      -X PUT \
      --header "Content-Type: application/json" \
      --data '{"configure":".*","write":".*","read":".*"}' \
      ${RABBITMQ_HOST}/api/permissions/${VHOST}/${USERNAME}
