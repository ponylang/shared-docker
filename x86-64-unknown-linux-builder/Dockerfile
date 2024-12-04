ARG FROM_TAG=release-alpine
FROM ghcr.io/ponylang/ponyc:${FROM_TAG}

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
