#!/bin/bash

docker build --rm -t serialize/$1 $1/
docker push serialize/$1