#!/bin/sh

LEMUR_PASSWORD="${LEMUR_PASSWORD:-lemur}"

lemur/lemur init -p "$LEMUR_PASSWORD"

exec "$@"
