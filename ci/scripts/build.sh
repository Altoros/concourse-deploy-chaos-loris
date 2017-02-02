#!/usr/bin/env bash
set -e

# you need to have java, mvn, ruby, bundler
pushd chaos-loris-repo
./mvnw clean package
popd

mv chaos-loris-repo/target/chaos-loris.jar binary
