#!/usr/bin/env bash
set -e -x

### Load env

export GOPATH=$PWD/service-broker-repo
cd service-broker-repo
go build 
