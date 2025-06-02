#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to GitHub Container Registry when you run
#     this ***
#

DOCKERFILE_DIR="$(dirname "$0")"
BUILDER="arm64-builder-$(date +%s)"
NAME="ghcr.io/ponylang/shared-docker-ci-arm64-unknown-linux-builder-with-libressl-4.0.0"

docker buildx create --use --name "${BUILDER}"

# built from arm64-unknown-linux-builder release tag
# FROM_TAG=release
# TAG_AS=release
# docker build --pull --build-arg FROM_TAG="${FROM_TAG}" \
#   -t "${NAME}:${TAG_AS}" "${DOCKERFILE_DIR}"
# docker push "${NAME}:${TAG_AS}"

# built from arm64-unknown-linux-builder latest tag
FROM_TAG=latest
TAG_AS=latest
docker buildx build  --provenance false --sbom false --platform linux/arm64 \
  --pull --push --build-arg FROM_TAG="${FROM_TAG}" -t "${NAME}:${TAG_AS}" \
  "${DOCKERFILE_DIR}"

docker buildx rm "${BUILDER}"
