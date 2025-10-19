#!/bin/bash
set -euo pipefail

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
    return 0
  fi

  echo "Combining images into manifest tag: ${NAME}:${TAG}"
  docker manifest create "${NAME}:${TAG}" "${sources[@]}"
  docker manifest push "${NAME}:${TAG}"

  echo "Manifest created successfully."
}

merge_images "nightly"
merge_images "release"
