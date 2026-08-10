FROM node:22-alpine

RUN npm install -g markdownlint-cli2@0.17.2 && \
  npm cache clean --force && \
  rm -rf /root/.npm

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
