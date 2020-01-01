#!/bin/bash

CA_NAME="${1}"
CA_CERT="-ca=/etc/certs/${CA_NAME}.pem"
CA_KEY="-ca-key=/etc/certs/${CA_NAME}-key.pem"

args=()
args+=("-address=0.0.0.0")
args+=("-port=8888")
if [[ -f config.json ]]; then
    args+=("-config=config.json")
fi
if [[ -f db-config.json ]]; then
    args+=("-db-config=db-config.json")
fi
if [[ -f "${CA_CERT}" ]]; then
    args+=("-ca=${CA_CERT}")
fi
if [[ -f "${CA_KEY}" ]]; then
    args+=("-ca-key=${CA_KEY}")
fi
if [[ -f "${csr_json}" ]]; then
    args+=("${csr_json}")
fi

cfssl serve "${args[@]}"
