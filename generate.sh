#!/bin/sh
set -e

service=$1; shift

set -x #echo on
swagger-cli validate bokun.yaml \
&& swagger-cli bundle bokun.yaml -o swagger-${service}.json
