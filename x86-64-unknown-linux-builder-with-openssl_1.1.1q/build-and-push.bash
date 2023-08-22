#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to DockerHub
#     and GitHub Container Registry when you run this ***
#

DOCKERFILE_DIR="$(dirname "$0")"

## DockerHub

NAME="ponylang/shared-docker-ci-x86-64-unknown-linux-builder-with-openssl_1.1.1q"

# built from x86-64-unknown-linux-builder release tag
FROM_TAG=release
TAG_AS=release
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t "${NAME}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"

# built from x86-64-unknown-linux-builder latest tag
FROM_TAG=latest
TAG_AS=latest
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t "${NAME}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"

## GitHub Container Registry

NAME="ghcr.io/ponylang/shared-docker-ci-x86-64-unknown-linux-builder-with-openssl_1.1.1q"

# built from x86-64-unknown-linux-builder release tag
FROM_TAG=release
TAG_AS=release
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t "${NAME}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"

# built from x86-64-unknown-linux-builder latest tag
FROM_TAG=latest
TAG_AS=latest
docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
  -t "${NAME}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"
