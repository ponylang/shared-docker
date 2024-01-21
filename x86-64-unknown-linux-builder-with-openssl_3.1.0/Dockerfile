ARG FROM_TAG=release
FROM ghcr.io/ponylang/shared-docker-ci-x86-64-unknown-linux-builder:${FROM_TAG}

RUN apk add --update --no-cache \
  clang-dev \
  linux-headers \
  perl

RUN cd /tmp && \
  wget https://www.openssl.org/source/old/3.1/openssl-3.1.0.tar.gz && \
  tar xf openssl-3.1.0.tar.gz && \
  cd openssl-3.1.0 && \
  ./Configure --api=3.0.0 no-shared linux-x86_64 enable-rc5 enable-md2 && \
  make && \
  make install && \
  cd /tmp && \
  rm -rf openssl-3.1.0

# For some reason, even though lib64 is in the linker search path, the
# libraries when installed there can't be found
RUN cp /usr/local/lib64/libssl.a /usr/local/lib/ && \
  cp /usr/local/lib64/libcrypto.a /usr/local/lib
