FROM alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && apk update \
  && apk upgrade \
  && apk add --update \
     bash \
     curl \
     git \
     shellcheck
