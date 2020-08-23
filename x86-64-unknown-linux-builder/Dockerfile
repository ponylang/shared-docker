ARG FROM_TAG=release-alpine
FROM ponylang/ponyc:${FROM_TAG}

RUN apk add --update --no-cache \
  alpine-sdk \
  binutils-gold \
  py-pip \
  curl \
  bash \
  make \
  build-base \
  libexecinfo-dev \
  libexecinfo-static \
  && pip install cloudsmith-cli
