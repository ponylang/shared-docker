ARG FROM_TAG=release
FROM ghcr.io/ponylang/ponyc:${FROM_TAG}

LABEL org.opencontainers.image.source="https://github.com/ponylang/shared-docker"
LABEL org.opencontainers.image.description="A basic pony building environment. Includes tools from the ponyc image plus some additional tools."

RUN apk add --update --no-cache \
  alpine-sdk \
  binutils-gold \
  py-pip \
  curl \
  bash \
  make \
  build-base \
  && pip install --break-system-packages cloudsmith-cli

RUN git config --global --add safe.directory '*'
