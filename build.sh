#!/bin/bash

NAME="serialize/${1}"
FOLDER="${1}/"

if [ $# -eq 2 ]; then
    NAME="serialize/${1}:${2}"
    FOLDER="${1}/${2}/"
fi

echo "----------------------------------"
echo "Building ${NAME}..."
echo "----------------------------------"
docker build --rm -t "${NAME}" "${FOLDER}"
echo ""
echo "----------------------------------"
echo "Pushing ${NAME}..."
echo "----------------------------------"
docker push "${NAME}"