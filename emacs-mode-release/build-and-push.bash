#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged into GitHub Container Registry
# when you run this ***
#

NAME="ponylang/shared-docker-ci-emacs-mode-release"
TODAY=$(date +%Y%m%d)
DOCKERFILE_DIR="$(dirname "$0")"

NAME="ghcr.io/${NAME}"
docker build --pull -t "${NAME}:${TODAY}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TODAY}"
