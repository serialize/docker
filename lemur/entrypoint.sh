#!/bin/sh

LEMUR_API_HOSTNAME="${LEMUR_API_HOSTNAME:-pki_api}"

sed -i "s/localhost/${LEMUR_API_HOSTNAME}/g" /opt/lemur/gulp/server.js && \
    

LEMUR_PASSWORD="${LEMUR_PASSWORD:-lemur}"

lemur init -p "$LEMUR_PASSWORD"

exec "$@"
