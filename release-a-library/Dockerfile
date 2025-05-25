ARG FROM_TAG=release-alpine
FROM ghcr.io/ponylang/changelog-tool:release AS changelog-tool

FROM ghcr.io/ponylang/ponyc:${FROM_TAG}

LABEL org.opencontainers.image.source="https://github.com/ponylang/shared-docker"

COPY --from=changelog-tool /usr/local/bin/changelog-tool /usr/local/bin/changelog-tool

RUN apk add --update --no-cache \
  bash \
  curl \
  git \
  jq \
  make

RUN git config --global --add safe.directory '*'
