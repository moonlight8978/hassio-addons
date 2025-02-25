ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH

RUN apk add --no-cache git yarn jq && \
  git clone --depth=1 https://github.com/actualbudget/actual.git /app && \
  cd /app && \
  yarn workspaces focus @actual-app/sync-server --production

COPY rootfs /
