ARG FROM_TAG=release
FROM ponylang/shared-docker-ci-x86-64-unknown-linux-builder:${FROM_TAG}

RUN cd /tmp && \
  wget https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.2.5.tar.gz && \
  tar xf libressl-3.2.5.tar.gz && \
  cd libressl-3.2.5/ && \
  ./configure && \
  make install && \
  cd /tmp && \
  rm -rf libressl*
