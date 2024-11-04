ARG ALPINE_VERSION=latest
ARG S6_OVERLAY_VERSION=v3.2.0.0-minimal

FROM socheatsok78/s6-overlay-distribution:${S6_OVERLAY_VERSION} AS s6-overlay-distribution

FROM alpine:${ALPINE_VERSION}
RUN apk add --no-cache avahi bash curl
COPY --link --from=s6-overlay-distribution / /
ADD rootfs /
ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
