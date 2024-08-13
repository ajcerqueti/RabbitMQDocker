#!/bin/bash

show_usage() {
    echo -e "Usage: $0 [HOST]"
    echo ""
}

if [ "$#" -ne 1 ]
then
    show_usage
    exit 1
fi

HOST=$1
ROOT=$(pwd)

# load config or exit
CONFIGFILE="${ROOT}/config/${HOST}.cfg"
if [ ! -f $CONFIGFILE ];
then
   echo "File $CONFIGFILE does not exist. Exiting..."
   exit 1
fi

source $CONFIGFILE

# /api/vhosts
curl \
    -u ${RABBITMQ_USER}:${RABBITMQ_PASS} \
    -X GET \
    ${RABBITMQ_HOST}/api/vhosts | python -m json.tool

