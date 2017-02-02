#!/usr/bin/env bash -e
# ./build-and-push allomov/deploy-worker

VERSION=${1:-latest}
#IMAGE_NAME=${1:-allomov/chaos-loris-build}
IMAGE_NAME=allomov/chaos-loris-build

docker build --no-cache=true -t $IMAGE_NAME:$VERSION -f docker/build.Dockerfile .
docker push $IMAGE_NAME
