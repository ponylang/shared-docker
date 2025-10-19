ARG FROM_TAG=release
FROM ghcr.io/ponylang/shared-docker-ci-standard-builder:${FROM_TAG}

LABEL org.opencontainers.image.source="https://github.com/ponylang/shared-docker"

RUN apk add --update --no-cache \
  clang-dev \
  linux-headers \
  perl

RUN cd /tmp && \
  wget https://github.com/openssl/openssl/releases/download/openssl-3.6.0/openssl-3.6.0.tar.gz && \
  tar xf openssl-3.6.0.tar.gz && \
  cd openssl-3.6.0 && \
  ./Configure --api=3.0.0 no-shared enable-rc5 enable-md2 && \
  make install_sw && \
  cd /tmp && \
  rm -rf openssl-3.6.0
