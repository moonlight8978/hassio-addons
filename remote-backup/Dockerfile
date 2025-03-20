ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH

RUN apk add --no-cache duplicity py3-boto3

COPY rootfs /
