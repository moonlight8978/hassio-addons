ARG BUILD_VERSION
ARG BUILD_FROM

FROM ghcr.io/wg-easy/wg-easy:${BUILD_VERSION} AS build

FROM ${BUILD_FROM}

WORKDIR /app

RUN apk add --no-cache \
    dpkg \
    iptables \
    ip6tables \
    kmod \
    iptables-legacy \
    wireguard-tools \
    nodejs \
    npm

COPY --from=build /app /app
# https://github.com/Homebrew/homebrew-core/blob/1e8de6ff92a7bf13ca0b87ad9ac380f5fde534b4/Formula/w/wireguard-tools.rb#L34-L35
RUN sed -i 's|/etc/wireguard|/data|g' /usr/bin/wg-quick \
    # https://github.com/jdeath/homeassistant-addons/blob/9689289a9db25ad1914ac96943e8617d97321ebf/wgeasy/Dockerfile#L7-L9
    && sed -i 's|/etc/wireguard|/data|g' server/chunks/nitro/nitro.mjs
RUN cd /app/server && npm install --no-save libsql

HEALTHCHECK --interval=1m --timeout=5s --retries=3 CMD /usr/bin/timeout 5s /bin/sh -c "/usr/bin/wg show | /bin/grep -q interface || exit 1"

COPY rootfs /

ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
ARG BUILD_ARCH

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
