#!/bin/sh
set -e # exit on errors

if [ ! -f "$1.yaml" ] ; then
    echo 'Usage:'
    echo '$0 service [lang]'
    echo
    echo 'service: The name of the service to generate, points to the file named service.yaml'
    echo '[lang]: The language to generate'
    exit 0
fi

if [ ! -d "target" ]; then
  mkdir target
fi

if [ ! -f "target/swagger-codegen-cli.jar" ]; then
  wget http://repo1.maven.org/maven2/io/swagger/swagger-codegen-cli/2.3.1/swagger-codegen-cli-2.3.1.jar -O target/swagger-codegen-cli.jar
fi

service=$1; shift

lang=$1; shift

set -x # echo on
swagger-cli validate ${service}.yaml

swagger-cli bundle ${service}.yaml -o target/${service}.json

version=`cat target/${service}.json | jq .info.version | sed 's/"//g'`

# generate the classes for the service in the given language
java -Dmodels -DsupportingFiles -jar target/swagger-codegen-cli.jar generate \
  -D java8=true,dateLibrary=java8-localdatetime,library=jersey2,modelPackage=io.bokun.api.model,groupId=io.bokun.api,artifactId=${service},artifactVersion=${version} \
  -l ${lang} \
  -i target/${service}.json \
  -o target/${service}-${lang} $@

# add the json file as a webjar to the source. This will allow the server to serve up its version of the api spec directly.
mkdir -p target/${service}-${lang}/src/main/resources/META-INF/resources/webjars/api
cp target/${service}.json target/${service}-${lang}/src/main/resources/META-INF/resources/webjars/api/
