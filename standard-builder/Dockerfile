ARG FROM_TAG=release
FROM ghcr.io/ponylang/ponyc:${FROM_TAG}

LABEL org.opencontainers.image.source="https://github.com/ponylang/shared-docker"
LABEL org.opencontainers.image.description="A basic pony building environment. Includes tools from the ponyc image plus some additional tools."

RUN apk add --update --no-cache \
  alpine-sdk \
  binutils-gold \
  py-pip \
  curl \
  bash \
  make \
  build-base \
  && pip install --break-system-packages cloudsmith-cli

ARG TARGETARCH
RUN UPLOADER_VERSION="0.1.0" \
  && if [ "$TARGETARCH" = "arm64" ]; then \
       UPLOADER_ARCH="arm64"; \
     else \
       UPLOADER_ARCH="x86-64"; \
     fi \
  && curl -fsSL "https://github.com/ponylang/cloudsmith-uploader/releases/download/${UPLOADER_VERSION}/cloudsmith-uploader-${UPLOADER_ARCH}-unknown-linux.tar.gz" \
     | tar -xz -C /usr/local --strip-components=1

RUN git config --global --add safe.directory '*'
