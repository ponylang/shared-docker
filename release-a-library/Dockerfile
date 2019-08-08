ARG FROM_TAG=release
FROM ponylang/changelog-tool:release AS changelog-tool

FROM ponylang/ponyc:${FROM_TAG}

COPY --from=changelog-tool /usr/local/bin/changelog-tool /usr/local/bin/changelog-tool

RUN  apt-get update && \
  apt-get -y install \
  curl \
  git \
  jq

RUN curl -O 'https://dl.cloudsmith.io/public/ponylang/nightlies/raw/versions/latest/stable-x86-64-unknown-linux.tar.gz' \
&& tar xvf stable* \
&& cp nightly-*/bin/stable /usr/local/bin/ \
&& rm -rf nightly-* *.tar.gz

RUN curl -O 'https://dl.cloudsmith.io/public/ponylang/nightlies/raw/versions/latest/corral-x86-64-unknown-linux.tar.gz' \
&& tar xvf corral* \
&& cp nightly-*/bin/corral /usr/local/bin \
&& rm -rf nightly-* *.tar.gz
