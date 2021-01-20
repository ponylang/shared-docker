ARG FROM_TAG=release-alpine
FROM ponylang/changelog-tool:release AS changelog-tool

FROM ponylang/ponyc:${FROM_TAG}

COPY --from=changelog-tool /usr/local/bin/changelog-tool /usr/local/bin/changelog-tool

RUN apk add --update --no-cache \
  bash \
  curl \
  git \
  jq \
  make
