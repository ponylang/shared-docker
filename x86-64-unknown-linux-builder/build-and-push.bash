#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to DockerHub
#     and GitHub Container Registry when you run this ***
#

DOCKERFILE_DIR="$(dirname "$0")"

## DockerHub

# built from ponyc release tag
NAME="ponylang/shared-docker-ci-x86-64-unknown-linux-builder"
FROM_TAG=release-alpine
TAG_AS=release
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t "${NAME}:${TAG_AS}" \
  "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"

# built from ponyc latest tag
FROM_TAG=alpine
TAG_AS=latest
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t "${NAME}:${TAG_AS}" \
  "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"

## GitHub Container Registry

# built from ponyc release tag
NAME="ghcr.io/ponylang/shared-docker-ci-x86-64-unknown-linux-builder"
FROM_TAG=release-alpine
TAG_AS=release
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t "${NAME}:${TAG_AS}" \
  "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"

# built from ponyc latest tag
FROM_TAG=alpine
TAG_AS=latest
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t "${NAME}:${TAG_AS}" \
  "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"
