ARG FROM_TAG=release-alpine
FROM ponylang/ponyc:${FROM_TAG}

RUN apk update \
  && apk upgrade \
  && apk upgrade curl \
  && apk add --update \
  alpine-sdk \
  binutils-gold \
  py-pip \
  curl \
  bash \
  make \
  build-base \
  libexecinfo-dev \
  && pip install cloudsmith-cli

# temporary fix for broken stable in the base image
RUN curl -O 'https://dl.cloudsmith.io/public/ponylang/nightlies/raw/versions/20191109/stable-x86-64-unknown-linux.tar.gz' \
 && gunzip stable-x86-64-unknown-linux.tar.gz \
 && tar xf stable-x86-64-unknown-linux.tar \
 && cp nightly-20191109/bin/stable /usr/local/bin/
