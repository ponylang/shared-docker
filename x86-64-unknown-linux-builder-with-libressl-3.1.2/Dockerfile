ARG FROM_TAG=release
FROM ponylang/shared-docker-ci-x86-64-unknown-linux-builder:${FROM_TAG}

RUN cd /tmp && \
  wget https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.1.2.tar.gz && \
  tar xf libressl-3.1.2.tar.gz && \
  cd libressl-3.1.2/ && \
  ./configure && \
  make install && \
  cd /tmp && \
  rm -rf libressl*
