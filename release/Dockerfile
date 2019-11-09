FROM ponylang/changelog-tool:release AS changelog-tool

FROM ubuntu:18.04

COPY --from=changelog-tool /usr/local/bin/changelog-tool /usr/local/bin/changelog-tool

RUN  apt-get update && \
  apt-get -y install \
  bash \
  curl \
  git \
  jq
