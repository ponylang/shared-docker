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
  make && \
  make install && \
  cd /tmp && \
  rm -rf openssl-3.6.0

# For some reason, even though lib64 is in the linker search path, the
# libraries when installed there can't be found
RUN cp /usr/local/lib64/libssl.a /usr/local/lib/ && \
  cp /usr/local/lib64/libcrypto.a /usr/local/lib
