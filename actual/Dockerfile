ARG BUILD_FROM

FROM $BUILD_FROM AS source

ARG BUILD_VERSION

RUN apk add --no-cache git yarn yq npm \
  && git clone --depth=1 --branch=$BUILD_VERSION https://github.com/actualbudget/actual.git /app \
  && cd /app/packages/desktop-client \
  && git clone https://github.com/actualbudget/translations.git locale

WORKDIR /app

FROM $BUILD_FROM AS builder

RUN yarn install
RUN yarn workspace @actual-app/sync-server build
RUN yarn workspace @actual-app/web build

FROM $BUILD_FROM AS node_modules

RUN yarn workspaces focus @actual-app/sync-server --production

FROM $BUILD_FROM

RUN apk add --no-cache yarn

WORKDIR /app

COPY --from=node_modules /app/node_modules /app/node_modules
RUN rm -rf ./node_modules/@actual-app/web ./node_modules/@actual-app/sync-server
COPY --from=builder /app/packages/desktop-client/package.json ./node_modules/@actual-app/web/package.json
COPY --from=builder /app/packages/desktop-client/build ./node_modules/@actual-app/web/build
COPY --from=builder /app/packages/sync-server/package.json /app/packages/sync-server/app.js ./
COPY --from=builder /app/packages/sync-server/src ./src
COPY --from=builder /app/packages/sync-server/migrations ./migrations

COPY rootfs /

ARG BUILD_ARCH
ARG BUILD_VERSION
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY

LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="_MoonLight_ <work@bichls.dev>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.authors="_MoonLight_ <work@bichls.dev>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
