FROM alpine:3.18

RUN apk add --update --no-cache \
  bash \
  py3-pyflakes \
  shellcheck

RUN cd /tmp && \
  wget https://github.com/rhysd/actionlint/releases/download/v1.6.25/actionlint_1.6.25_linux_386.tar.gz && \
  tar xf actionlint_1.6.25_linux_386.tar.gz && \
  cp actionlint /usr/bin/ && \
  chmod a+x /usr/bin/actionlint && \
  rm -rf /tmp/*

 ENTRYPOINT ["/usr/bin/actionlint"]
