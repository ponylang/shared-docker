FROM alpine:3.18 AS builder

RUN apk add --update --no-cache \
  bash \
  py3-pyflakes \
  shellcheck

RUN cd /tmp && \
  wget https://github.com/rhysd/actionlint/releases/download/v1.6.27/actionlint_1.6.27_linux_386.tar.gz && \
  tar xf actionlint_1.6.27_linux_386.tar.gz && \
  cp actionlint /usr/bin/ && \
  chmod a+x /usr/bin/actionlint

FROM scratch

COPY --from=builder /usr/bin/actionlint /usr/bin/actionlint

 ENTRYPOINT ["/usr/bin/actionlint"]
