#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to GitHub Container Registry when you run
#     this ***
#

DOCKERFILE_DIR="$(dirname "$0")"
BUILDER="standard-builder-$(date +%s)"
NAME="ghcr.io/ponylang/shared-docker-ci-standard-builder"

docker buildx create --use --name "${BUILDER}"

echo "Building nightly image from ponyc nightly tag"
docker buildx build --provenance false --sbom false \
  --platform linux/arm64,linux/amd64 --pull --push --build-arg \
  FROM_TAG="nightly" -t "${NAME}:nightly" "${DOCKERFILE_DIR}"

echo "Building release image from ponyc release tag"
docker buildx build --provenance false --sbom false \
  --platform linux/arm64,linux/amd64 --pull --push --build-arg \
  FROM_TAG="release" -t "${NAME}:release" "${DOCKERFILE_DIR}"

docker buildx rm "${BUILDER}"
