#!/usr/bin/env bash
set -e

### Load env

mkdir -p ../go/src/github.com/Altoros/
cp -r service-broker-repo/ ../go/src/github.com/Altoros/cf-chaos-loris-broker
cd ..
export GOPATH=$PWD/go/ 
cd go/src/github.com/Altoros/cf-chaos-loris-broker
#go get -d -t -v github.com/Altoros/cf-chaos-loris-broker
go build 
cp cf-chaos-loris-broker ../binary/
cp plans.yml ../binary/
