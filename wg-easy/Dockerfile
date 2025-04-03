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

RUN update-alternatives --install /usr/sbin/iptables iptables /usr/sbin/iptables-legacy 10 --slave /usr/sbin/iptables-restore iptables-restore /usr/sbin/iptables-legacy-restore --slave /usr/sbin/iptables-save iptables-save /usr/sbin/iptables-legacy-save
    # && update-alternatives --install /usr/sbin/ip6tables ip6tables /usr/sbin/ip6tables-legacy 10 --slave /usr/sbin/ip6tables-restore ip6tables-restore /usr/sbin/ip6tables-legacy-restore --slave /usr/sbin/ip6tables-save ip6tables-save /usr/sbin/ip6tables-legacy-save

COPY --from=build /app /app
# ref https://github.com/jdeath/homeassistant-addons/blob/9689289a9db25ad1914ac96943e8617d97321ebf/wgeasy/Dockerfile#L7-L9
RUN sed -i 's|up ${infName}|up /data/${infName}.conf|g' server/chunks/nitro/nitro.mjs \
    && sed -i 's|down ${infName}|down /data/${infName}.conf|g' server/chunks/nitro/nitro.mjs \
    && sed -i 's|strip ${infName}|strip /data/${infName}.conf|g' server/chunks/nitro/nitro.mjs \
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
