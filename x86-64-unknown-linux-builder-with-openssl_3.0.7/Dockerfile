ARG FROM_TAG=release
FROM ponylang/shared-docker-ci-x86-64-unknown-linux-builder:${FROM_TAG}

RUN apk add --update --no-cache \
  clang-dev \
  linux-headers \
  perl

RUN cd /tmp && \
  wget https://www.openssl.org/source/openssl-3.0.7.tar.gz && \
  tar xf openssl-3.0.7.tar.gz && \
  cd openssl-3.0.7 && \
  ./Configure --api=1.1.0 no-shared linux-x86_64 enable-rc5 enable-md2 && \
  make install_sw && \
  cd /tmp && \
  rm -rf openssl-3.0.7
