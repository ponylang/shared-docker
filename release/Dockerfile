FROM ponylang/changelog-tool:release AS changelog-tool

FROM ubuntu:18.04

COPY --from=changelog-tool /usr/local/bin/changelog-tool /usr/local/bin/changelog-tool

RUN  apt-get update \
  && apt-get -y install --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    git \
    jq \
  && rm -rf /var/lib/apt/lists/*
