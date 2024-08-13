#!/bin/bash

show_usage() {
    echo -e "Usage: $0 [HOST] [VHOST]"
    echo ""
}

if [ "$#" -ne 2 ]
then
    show_usage
    exit 1
fi

HOST=$1
VHOST=$2
ROOT=$(pwd)

# load config or exit
CONFIGFILE="${ROOT}/config/${HOST}.cfg"
if [ ! -f $CONFIGFILE ];
then
   echo "File $CONFIGFILE does not exist. Exiting..."
   exit 1
fi

source $CONFIGFILE

# /api/queues/vhost
RESPONSE=$(curl -s \
    -u ${RABBITMQ_USER}:${RABBITMQ_PASS} \
    -X GET \
    ${RABBITMQ_HOST}/api/queues/${VHOST}/messages)
MESSAGES=$(echo $RESPONSE | python3 -c  'import json,sys;print(json.load(sys.stdin)["messages"])')
echo "Messages in ${VHOST} messages queue: ${MESSAGES}"
