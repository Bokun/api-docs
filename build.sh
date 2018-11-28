#!/bin/sh
./generate.sh $1 java
cd target/$1-java/
mvn source:jar install