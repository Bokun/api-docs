#!/bin/sh
set -e
set -x #echo on

generate() {
  service=$1

  swagger-cli validate bokun.yaml && swagger-cli bundle bokun.yaml -o swagger-"${service}".json

  if [ "$service" = "test" ]; then
      sed -i.bak 's/api.bokun.io/api.bokuntest.com/' swagger-"${service}".json
      rm swagger-"${service}".json.bak
  fi
}

if [ "$*" != "" ]; then
  generate "$*"
else
  generate prod
  generate test
fi
