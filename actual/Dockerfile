ARG BUILD_FROM
ARG BUILD_VERSION

FROM docker.io/actualbudget/actual-server:${BUILD_VERSION} AS source

FROM $BUILD_FROM

RUN apk add --no-cache yq npm

WORKDIR /app

COPY --from=source /app ./
RUN npm rebuild better-sqlite3

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
