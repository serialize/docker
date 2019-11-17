#!/bin/bash

set -e

PARAMS=()

function handle_db_config
{
    if [ -z "${CFSSL_DB_PASSWORD}" ]; then

        db_pw="${CFSSL_DB_PASSWORD}"
        db_host="${CFSSL_DB_HOSTNAME:-db}"
        db_port="${CFSSL_DB_PORT:-5432}"
        db_user="${CFSSL_DB_HOSTNAME:-postgres}"
        db_name="${CFSSL_DB_NAME:-postgres}"

        db_uri="postgres://${db_user}:${db_pw}@${db_host}:${db_port}/${db_name}?sslmode=disable"

        {
            echo '{'
            echo '  "driver": "postgres",'
            echo '  "data_source": "$db_uri"'
            echo '}'
        }  > /etc/cfssl/db-config.json

    fi
}


function check_value_param
{
    if [[ ! -z "${2}" ]]; then
        echo "-${1}=${2}"
    fi
}


function check_file_param
{
    if [[ ! -z "${2}" || -f "${2}" ]]; then
        echo "-${1}=${2}"
    fi
}

#for f in /entrypoint-init.d/*
#do
#    if [ -x "$f" ]; then
#        echo "$0: running $f"
#
#        set -e
 #       EXIT_CODE=0
 #       "$f" || EXIT_CODE=$?
 #   else
 #       echo "$0: sourcing $f"
  #      . "$f"
  #  fi

#
#done


handle_db_config

address="${CFSSL_ADDRESS:-0.0.0.0}"
port="${CFSSL_PORT:-8888}"

check_value_param "address" "${CFSSL_ADDRESS}"
check_value_param "port" "${CFSSL_PORT}"

CFSSL_CA_CERT="${CFSSL_CA_CERT:-/etc/cfssl/ca.pem}"
CFSSL_CA_KEY="${CFSSL_CA_KEY:-/etc/cfssl/ca-key.pem}"
CFSSL_CA_BUNDLE="${CFSSL_CA_BUNDLE:-/etc/cfssl/ca-bundle.crt}"
CFSSL_INT_BUNDLE="${CFSSL_INT_BUNDLE:-/etc/cfssl/int-bundle.crt}"

CFSSL_CONFIG="${CFSSL_CONFIG:-/etc/cfssl/config.json}"

result=$(check_file_param ca $CFSSL_CA_CERT)
echo $result
PARAMS+=( $result )

result=$(check_file_param ca-key $CFSSL_CA_KEY)
echo $result
PARAMS+=( $result )

result=$(check_file_param ca-bundle $CFSSL_CA_BUNDLE)
echo $result
PARAMS+=( $result )

result=$(check_file_param int-bundle $CFSSL_INT_BUNDLE)
echo $result
PARAMS+=( $result )

result=$(check_file_param config $CFSSL_CONFIG)
echo $result
PARAMS+=( $result )

exec "$@" "${PARAMS[@]}"

exit 0