ARG BUILD_FROM

FROM node:23-alpine AS frontend
ARG BUILD_VERSION

RUN apk add --update --no-cache git \
    && npm install -g pnpm

RUN git clone --depth=1 --branch=${BUILD_VERSION} https://github.com/usememos/memos.git /frontend-build \
    && cd /frontend-build/web \
    && pnpm i --frozen-lockfile \
    && pnpm build --base "./"

FROM golang:1.24-alpine AS backend
ARG BUILD_VERSION

WORKDIR /backend-build

RUN apk add --update --no-cache git

RUN git clone --depth=1 --branch=${BUILD_VERSION} https://github.com/usememos/memos.git /backend-build
COPY --from=frontend /frontend-build/web/dist /backend-build/server/router/frontend/dist
RUN go build -o memos ./bin/memos/main.go

FROM ${BUILD_FROM}

COPY --from=backend /backend-build/memos /usr/local/memos/

COPY rootfs /

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

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
