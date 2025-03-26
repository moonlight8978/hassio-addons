ARG BUILD_FROM

FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH

RUN ARCH=${BUILD_ARCH}; \
    if [ "$ARCH" = "aarch64" ]; then ARCH="arm64"; fi; \
    curl -fsSL "https://github.com/traefik/traefik/releases/download/${BUILD_VERSION}/traefik_${BUILD_VERSION}_linux_${ARCH}.tar.gz" -o traefik.tar.gz \
    && tar -xvf traefik.tar.gz \
    && mv traefik /traefik \
    && chmod +x /traefik \
    && rm -f traefik.tar.gz

COPY rootfs /

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
