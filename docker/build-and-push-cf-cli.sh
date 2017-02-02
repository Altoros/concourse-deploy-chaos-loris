#!/usr/bin/env bash -e
# ./build-and-push allomov/deploy-worker

VERSION=${1:-latest}
IMAGE_NAME=allomov/cf-cli
# IMAGE_NAME=${1:-allomov/cf-cli}

docker build --no-cache=true -t $IMAGE_NAME:$VERSION -f docker/cf-cli.Dockerfile .
docker push $IMAGE_NAME
