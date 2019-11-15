#!/bin/bash

set -e

args=()

address="${CFSSL_ADDRESS:-0.0.0.0}"
port="${CFSSL_PORT:-8888}"
ca_cert="${CFSSL_CA_CERT:-/etc/cfssl/ca.pem}"
ca_key="${CFSSL_CA_KEY:-/etc/cfssl/ca-key.pem}"
config="${CFSSL_CONFIG:-/etc/cfssl/config.json}"
db_config="${CFSSL_DB_CONFIG:-/etc/cfssl/db-config.json}"
ca_bundle="${CFSSL_CA_BUNDLE:-/etc/cfssl/ca-bundle.crt}"
int_bundle="${CFSSL_INT_BUNDLE:-/etc/cfssl/int-bundle.crt}"

if [ "$2" == "serve" ]; then

    if [[ $@ != *'-address='* ]] && [[ $@ != *'-address '* ]] && [[ -f "${address}" ]]; then
        args+=("-address=${address}")
    fi

    if [[ $@ != *'-port='* ]] && [[ $@ != *'-port '* ]] && [[ -f "${port}" ]]; then
        args+=("-port=${port}")
    fi
fi

if [ "$1" == "cfssl" ]; then

    if [[ $@ != *'-ca='* ]] && [[ $@ != *'-ca '* ]] && [[ -f "${ca_cert}" ]]; then
        args+=("-ca=${ca_cert}")
    fi

    if [[ $@ != *'-ca-key='* ]] && [[ $@ != *'-ca-key '* ]] && [[ -f "${ca_key}" ]]; then
        args+=("-ca-key=${ca_key}")
    fi

    if [[ $@ != *'-config='* ]] && [[ $@ != *'-config '* ]] && [[ -f "${config}" ]]; then
        args+=("-config=${config}")
    fi

    if [[ $@ != *'-db-config='* ]] && [[ $@ != *'-db-config '* ]] && [[ -f "${db_config}" ]]; then
        args+=("-db-config=${db_config}")
    fi

    if [[ $@ != *'-ca-bundle='* ]] && [[ $@ != *'-ca-bundle '* ]] && [[ -f "${ca_bundle}" ]]; then
        args+=("-ca-bundle=${ca_bundle}")
    fi

    if [[ $@ != *'-int-bundle='* ]] && [[ $@ != *'-int-bundle '* ]] && [[ -f "${int_bundle}" ]]; then
        args+=("-inr-bundle=${int_bundle}")
    fi

fi

echo "${args[@]}"

exec "$@" "${args[@]}"

