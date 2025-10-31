#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to GitHub Container Registry when you run
#     this ***
#

DOCKERFILE_DIR="$(dirname "$0")"

## GitHub Container Registry

NAME="ghcr.io/ponylang/shared-docker-ci-x86-64-unknown-linux-builder-with-libressl-3.9.2"

# built from standard-builder release tag
FROM_TAG=release
TAG_AS=release
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t "${NAME}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"

# built from standard-builder nightly tag
FROM_TAG=nightly
TAG_AS=latest
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t "${NAME}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"
