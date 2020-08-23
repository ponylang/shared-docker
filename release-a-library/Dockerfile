ARG FROM_TAG=release
FROM ponylang/changelog-tool:release AS changelog-tool

FROM ponylang/ponyc:${FROM_TAG}

COPY --from=changelog-tool /usr/local/bin/changelog-tool /usr/local/bin/changelog-tool

RUN  apt-get update \
  && apt-get -y install --no-install-recommends \
    ca-certificates \
    curl \
    git \
    jq \
  && rm -rf /var/lib/apt/lists/*

