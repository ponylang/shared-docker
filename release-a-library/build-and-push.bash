#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to DockerHub when you run this ***
#

DOCKERFILE_DIR="$(dirname "$0")"

# built from ponyc release tag
FROM_TAG=release
docker build --build-arg FROM_TAG="${FROM_TAG}" \
  -t ponylang/shared-docker-ci-release-a-library:"${FROM_TAG}" \
  "${DOCKERFILE_DIR}"
docker push ponylang/shared-docker-ci-release-a-library:"${FROM_TAG}"

# built from ponyc latest tag
FROM_TAG=latest
docker build --build-arg FROM_TAG="${FROM_TAG}" \
  -t ponylang/shared-docker-ci-release-a-library:"${FROM_TAG}" \
  "${DOCKERFILE_DIR}"
docker push ponylang/shared-docker-ci-release-a-library:"${FROM_TAG}"
