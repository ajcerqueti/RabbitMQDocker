#!/bin/bash

show_usage() {
    echo -e "Usage: $0 [HOST] [USERNAME]"
    echo ""
}

if [ "$#" -ne 2 ]
then
    show_usage
    exit 1
fi

HOST=$1
USERNAME=$2
ROOT=$(pwd)

# load config or exit
CONFIGFILE="${ROOT}/config/${HOST}.cfg"
if [ ! -f $CONFIGFILE ];
then
   echo "File $CONFIGFILE does not exist. Exiting..."
   exit 1
fi

source $CONFIGFILE

# /api/users/{name}
curl -i \
    -u ${RABBITMQ_USER}:${RABBITMQ_PASS} \
    -X DELETE \
    ${RABBITMQ_HOST}/api/users/${USERNAME}
