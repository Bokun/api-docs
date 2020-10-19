#!/bin/sh
set -e

service=$1; shift

set -x #echo on
swagger-cli validate bokun.yaml \
&& swagger-cli bundle bokun.yaml -o swagger-${service}.json

if [[ "$service" = "test" ]]; then
    sed -i 's/api.bokun.io/api.bokuntest.com/' swagger-${service}.json
fi