#!/bin/bash

show_usage() {
    echo -e "Usage: $0 [HOST] [USERNAME] [PASSWORD]"
    echo ""
}

if [ "$#" -ne 3 ]
then
    show_usage
    exit 1
fi

HOST=$1
USERNAME=$2
PASSWORD=$3
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
    -X PUT \
    --header "Content-Type: application/json" \
    --data '{"password":"${PASSWORD}","tags":"administrator"}' \
    ${RABBITMQ_HOST}/api/users/${USERNAME}

