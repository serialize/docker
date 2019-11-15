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
        PARAMS+=("-${1}=${2}")
    fi
}


function check_file_param
{
    if [[ ! -z "${2}" || -f "${2}" ]]; then
        PARAMS+=("-${1}=${2}")
    fi
}



address="${CFSSL_ADDRESS:-0.0.0.0}"
port="${CFSSL_PORT:-8888}"

check_value_param "address" "${CFSSL_ADDRESS}"
check_value_param "port" "${CFSSL_PORT}"


ca_cert="${CFSSL_CA_CERT:-/etc/cfssl/ca.pem}"
ca_key="${CFSSL_CA_KEY:-/etc/cfssl/ca-key.pem}"
ca_bundle="${CFSSL_CA_BUNDLE:-/etc/cfssl/ca-bundle.crt}"
int_bundle="${CFSSL_INT_BUNDLE:-/etc/cfssl/int-bundle.crt}"

config="${CFSSL_CONFIG:-/etc/cfssl/config.json}"
db_config="${CFSSL_DB_CONFIG:-/etc/cfssl/db-config.json}"

check_file_param "ca" "${CFSSL_CA_CERT}"
check_file_param "ca-key" "${CFSSL_CA_KEY}"
check_file_param "ca-bundle" "${CFSSL_CA_BUNDLE}"
check_file_param "int-bundle" "${CFSSL_INT_BUNDLE}"

check_file_param "config" "${CFSSL_CONFIG}"
check_file_param "db-config" "${CFSSL_DB_CONFIG}"



exec "$@" "${PARAMS[@]}"

