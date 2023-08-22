#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to DockerHub
#     and GitHub Container Registry when you run this ***
#

NAME="ponylang/shared-docker-ci-actionlint"
TODAY=$(date +%Y%m%d)
DOCKERFILE_DIR="$(dirname "$0")"

# DockerHub
docker build --pull -t "${NAME}:${TODAY}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TODAY}"

# GitHub Container Registry
NAME="ghcr.io/${NAME}"
docker build --pull -t "${NAME}:${TODAY}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TODAY}"
