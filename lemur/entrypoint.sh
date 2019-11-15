#!/bin/sh

LEMUR_PASSWORD="${LEMUR_PASSWORD:-lemur}"

lemur init -p "$LEMUR_PASSWORD"

exec "$@"
