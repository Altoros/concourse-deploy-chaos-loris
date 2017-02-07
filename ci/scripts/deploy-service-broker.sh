#!/usr/bin/env bash
set -e -x

### Load env

cp -r service-broker-repo/ go/src/github.com/Altoros/cf-chaos-loris-broker
export GOPATH=$PWD/go/ 
cd go/src/github.com/Altoros/cf-chaos-loris-broker
go get -d -t -v github.com/Altoros/cf-chaos-loris-broker
go build 
