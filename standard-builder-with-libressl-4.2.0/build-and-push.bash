#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to GitHub Container Registry when you run
#     this ***
#

ARCH=$(uname -m)
case "${ARCH}" in
  x86_64)
    ARCH_TAG="amd64"
    ;;
  aarch64|arm64)
    ARCH_TAG="arm64"
    ;;
  *)
    echo "Error: Unsupported architecture '${ARCH}'" >&2
    exit 1
    ;;
esac

DOCKERFILE_DIR="$(dirname "$0")"
BUILDER="standard-builder-with-libressl-4.2.0-$(date +%s)"
NAME="ghcr.io/ponylang/shared-docker-ci-standard-builder-with-libressl-4.2.0"

echo "Building nightly image from standard-builder nightly tag"
docker buildx create --use --name "${BUILDER}"
docker buildx build --provenance false --sbom false \
  --pull --push --build-arg \
  FROM_TAG="nightly" -t "${NAME}:nightly-${ARCH_TAG}" "${DOCKERFILE_DIR}"
docker buildx rm "${BUILDER}"

echo "Building release image from standard-builder release tag"
docker buildx create --use --name "${BUILDER}"
docker buildx build --provenance false --sbom false \
  --pull --push --build-arg \
  FROM_TAG="release" -t "${NAME}:release-${ARCH_TAG}" "${DOCKERFILE_DIR}"
docker buildx rm "${BUILDER}"
