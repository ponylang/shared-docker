ARG FROM_TAG=release
FROM ghcr.io/ponylang/shared-docker-ci-standard-builder:${FROM_TAG}

LABEL org.opencontainers.image.source="https://github.com/ponylang/shared-docker"

RUN apk add --update --no-cache pcre2-dev
