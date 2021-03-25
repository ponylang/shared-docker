ARG FROM_TAG=release
FROM ponylang/shared-docker-ci-x86-64-unknown-linux-builder:${FROM_TAG}

RUN apk add --update --no-cache \
  clang-dev \
  linux-headers \
  perl

RUN cd /tmp && \
  wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_1k.tar.gz && \
  tar xf OpenSSL_1_1_1k.tar.gz && \
  cd openssl-OpenSSL_1_1_1k && \
  ./Configure --api=1.1.0 no-shared linux-x86_64 enable-rc5 enable-md2 && \
  make install_sw && \
  cd /tmp && \
  rm -rf openssl-OpenSSL_1_1_1k
