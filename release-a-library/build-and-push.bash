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
docker build --pull --build-arg FROM_TAG=release" \
  -t "${NAME}:$release" \
  "${DOCKERFILE_DIR}"
docker push "${NAME}:release"

# built from ponyc nightly tag
docker build --pull --build-arg FROM_TAG="nightly" \
  -t "${NAME}:nightly" \
  "${DOCKERFILE_DIR}"
docker push "${NAME}:nightly"
