ARG FROM_TAG=release
FROM ponylang/ponyc:${FROM_TAG}

RUN apk update \
  && apk upgrade \
  && apk upgrade curl \
  && apk add --update \
  py-pip \
  curl \
  && pip install cloudsmith-cli
