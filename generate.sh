#!/bin/sh
set -e

service=$1; shift

set -x #echo on
swagger validate bokun.yaml \
&& swagger bundle bokun.yaml -o swagger-${service}.json

