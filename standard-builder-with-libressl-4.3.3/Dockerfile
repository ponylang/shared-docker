ARG FROM_TAG=release
FROM ghcr.io/ponylang/shared-docker-ci-standard-builder:${FROM_TAG}

LABEL org.opencontainers.image.source="https://github.com/ponylang/shared-docker"

RUN cd /tmp && \
  wget https://cdn.openbsd.org/pub/OpenBSD/LibreSSL/libressl-4.3.3.tar.gz && \
  tar xf libressl-4.3.3.tar.gz && \
  cd libressl-4.3.3/ && \
  ./configure && \
  make install && \
  cd /tmp && \
  rm -rf libressl*
