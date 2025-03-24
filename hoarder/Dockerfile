ARG BUILD_VERSION
ARG BUILD_FROM

FROM ghcr.io/hoarder-app/hoarder:${BUILD_VERSION} AS build

FROM ghcr.io/zenika/alpine-chrome:124 AS chrome-build

FROM ${BUILD_FROM}

######################
# Install hoarder application
# https://github.com/hoarder-app/hoarder/blob/main/docker/Dockerfile
######################

# Install runtime dependencies
RUN apk add --no-cache \
    # Hoarder
    monolith \
    yt-dlp \
    graphicsmagick \
    ghostscript \
    nodejs \
    pnpm \
    # Chromium
    chromium-swiftshader \
    ttf-freefont \
    font-noto-emoji \
    && apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    font-wqy-zenhei

# Install services
COPY --from=build /etc/s6-overlay /etc/s6-overlay

# Install webapp
COPY --from=build /app /app
COPY --from=build /db_migrations /db_migrations

######################
# Install chrome config
# https://github.com/jlandure/alpine-chrome/blob/master/Dockerfile
######################
COPY --from=chrome-build /etc/fonts/local.conf /etc/fonts/local.conf

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

# Install custom services
COPY rootfs /

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY

ENV SERVER_VERSION=${BUILD_VERSION}

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD wget --no-verbose --tries=1 --spider http://127.0.0.1:3000/api/health || exit 1

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
