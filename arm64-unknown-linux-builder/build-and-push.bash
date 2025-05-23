#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to GitHub Container Registry when you run
#     this ***
#

DOCKERFILE_DIR="$(dirname "$0")"
BUILDER="arm64-builder-$(date +%s)"
NAME="ghcr.io/ponylang/shared-docker-ci-arm64-unknown-linux-builder"

docker buildx create --use --name "${BUILDER}"

# built from ponyc release tag
# FROM_TAG=release-alpine-arm64
# TAG_AS=release
# docker buildx build --platform linux/arm64 --pull \
#   --build-arg FROM_TAG="${FROM_TAG}" -t "${NAME}:${TAG_AS}" \
#   --output "type=image,push=true" "${DOCKERFILE_DIR}"

# built from ponyc latest tag
FROM_TAG=alpine-arm64
TAG_AS=latest
docker buildx build --platform linux/arm64 --pull \
  --build-arg FROM_TAG="${FROM_TAG}" -t "${NAME}:${TAG_AS}" \
  --output "type=image,push=true" "${DOCKERFILE_DIR}"

docker buildx stop "${BUILDER}"
