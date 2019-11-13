#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to DockerHub when you run this ***
#

DOCKERFILE_DIR="$(dirname "$0")"

# built from ponyc release tag
FROM_TAG=release-alpine
TAG_AS=release
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t ponylang/shared-docker-ci-x86-64-unknown-linux-builder:"${TAG_AS}" \
  "${DOCKERFILE_DIR}"
docker push ponylang/shared-docker-ci-x86-64-unknown-linux-builder:"${TAG_AS}"

# built from ponyc latest tag
FROM_TAG=alpine
TAG_AS=latest
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t ponylang/shared-docker-ci-x86-64-unknown-linux-builder:"${TAG_AS}" \
  "${DOCKERFILE_DIR}"
docker push ponylang/shared-docker-ci-x86-64-unknown-linux-builder:"${TAG_AS}"
