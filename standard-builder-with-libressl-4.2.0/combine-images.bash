#!/bin/bash

set -o errexit
set -o nounset

NAME="ghcr.io/ponylang/shared-docker-ci-standard-builder-with-libressl-4.2.0"

sources=()

# function to check if an image exists
check_image() {
  local image="$1"
  if docker manifest inspect "$image" > /dev/null 2>&1; then
    echo "Image exists: $image"
    sources+=("$image")
  else
    echo "Image not found: $image"
  fi
}

merge_images() {
  local TAG="$1"
  echo "Checking available architecture images for ${NAME}:$TAG"

  check_image "${NAME}:${TAG}-amd64"
  check_image "${NAME}:${TAG}-arm64"

  if [ ${#sources[@]} -eq 0 ]; then
    echo "No images found for merging, skipping."
    return
  fi

  echo "Creating or updating manifest tag: ${NAME}:${TAG}"

  # Attempt to inspect existing manifest
  if docker manifest inspect "${NAME}:${TAG}" >/dev/null 2>&1; then
    echo "Existing manifest found, updating it."
    docker manifest create --amend "${NAME}:${TAG}" "${sources[@]}"
  else
    echo "No existing manifest found, creating new one."
    docker manifest create "${NAME}:${TAG}" "${sources[@]}"
  fi
  docker manifest push "${NAME}:${TAG}"

  echo "Manifest created or updated successfully."
}

merge_images "nightly"
merge_images "release"
