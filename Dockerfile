ARG ALPINE_VERSION=latest
ARG S6_OVERLAY_VERSION=v3.2.0.0-minimal

FROM socheatsok78/s6-overlay-distribution:${S6_OVERLAY_VERSION} AS s6-overlay-distribution
FROM ghcr.io/swarmlibs/go-discover:main AS go-discover
FROM ghcr.io/swarmlibs/go-netaddrs:main AS go-netaddrs
FROM ghcr.io/swarmlibs/go-sockaddr:main AS go-sockaddr

FROM alpine:${ALPINE_VERSION}
COPY --link --from=go-discover /discover /usr/bin/go-discover
COPY --link --from=go-netaddrs /netaddrs /usr/bin/go-netaddrs
COPY --link --from=go-sockaddr /sockaddr /usr/bin/go-sockaddr
RUN apk add --no-cache avahi bash curl dbus libcap openresolv
RUN rm -f /etc/avahi/services/*.service
COPY --link --from=s6-overlay-distribution / /
ADD rootfs /
ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
