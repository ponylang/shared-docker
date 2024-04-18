ARG FROM_TAG=release
FROM ghcr.io/ponylang/shared-docker-ci-x86-64-unknown-linux-builder:${FROM_TAG}

RUN cd /tmp && \
  wget https://cdn.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.9.1.tar.gz && \
  tar xf libressl-3.9.1.tar.gz && \
  cd libressl-3.9.1/ && \
  ./configure && \
  make install && \
  cd /tmp && \
  rm -rf libressl*
