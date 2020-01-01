#!/bin/bash

CA_NAME="${1}"
CA_CERT="-ca=/etc/certs/${CA_NAME}.pem"
CA_KEY="-ca-key=/etc/certs/${CA_NAME}-key.pem"

cfssl serve -address=0.0.0.0 \
            -port=8888 \
            -config=config.json \
            -db-config=db-config.json \
            $CA_CERT \
            $CA_KEY

