#!/bin/sh
set -e

service=$1; shift

set -x #echo on
/usr/bin/swagger-cli validate bokun.yaml \
&& /usr/bin/swagger-cli bundle bokun.yaml -o swagger-${service}.json
