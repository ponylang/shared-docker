FROM alpine:3.23 AS builder

RUN cd /tmp && \
  wget https://github.com/koalaman/shellcheck/releases/download/v0.10.0/shellcheck-v0.10.0.linux.x86_64.tar.xz && \
  tar xf shellcheck-v0.10.0.linux.x86_64.tar.xz && \
  cp shellcheck-v0.10.0/shellcheck /usr/bin/ && \
  chmod a+x /usr/bin/shellcheck

FROM alpine:3.23

COPY --from=builder /usr/bin/shellcheck /usr/bin/shellcheck
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
