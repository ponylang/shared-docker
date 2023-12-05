#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to GitHub Container Registry when you run
#     this ***
#

DOCKERFILE_DIR="$(dirname "$0")"

## GitHub Container Registry

# built from ponyc release tag
NAME="ghcr.io/ponylang/shared-docker-ci-release-a-library"
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
