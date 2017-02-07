#!/usr/bin/env bash
set -e -x

### Load env

export GOPATH=./service-broker-repo
cd ./service-broker-repo
go build 
