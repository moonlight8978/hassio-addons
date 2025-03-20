ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH

RUN apk add --no-cache duplicity py3-boto3

RUN rm -rf /run/s6-rc/scandir/s6rc-fdholder /run/s6-rc/scandir/s6rc-oneshot-runner /run/s6-rc/scandir/s6-linux-init-shutdownd

COPY rootfs /

CMD ["/entrypoint.sh"]
