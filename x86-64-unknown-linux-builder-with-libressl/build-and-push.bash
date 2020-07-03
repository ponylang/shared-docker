#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to DockerHub when you run this ***
#

DOCKERFILE_DIR="$(dirname "$0")"
IMAGE="ponylang/shared-docker-ci-x86-64-unknown-linux-builder-with-libressl"

# built from x86-64-unknown-linux-builder release tag
FROM_TAG=release
TAG_AS=release
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t "${IMAGE}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${IMAGE}:${TAG_AS}"

# built from x86-64-unknown-linux-builder latest tag
FROM_TAG=latest
TAG_AS=latest
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t "${IMAGE}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${IMAGE}:${TAG_AS}"
