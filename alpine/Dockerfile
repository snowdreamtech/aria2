FROM snowdreamtech/alpine:3.20.3

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Base Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for Base on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/aria2" \
    org.opencontainers.image.base.name="snowdreamtech/aria2:alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/aria2" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="3.20.3" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/aria2"

ENV ARIA2_VERSION=1.37.0-r0 \
    ARIANG_VERSION=1.3.7

RUN apk add --no-cache aria2-daemon=${ARIA2_VERSION} \
    nginx \
    && mkdir -p /var/lib/aria2/.aria2  \
    && mkdir -p /var/lib/aria2/downloads  \
    && touch /var/lib/aria2/.aria2/aria2.session  \
    && chown -R aria2:aria2 /var/lib/aria2 \
    && wget -c https://github.com/mayswind/AriaNg/releases/download/${ARIANG_VERSION}/AriaNg-${ARIANG_VERSION}.zip \
    && unzip -o -d /var/lib/nginx/html AriaNg-${ARIANG_VERSION}.zip  \
    && rm -rfv AriaNg-${ARIANG_VERSION}.zip

COPY http.d /etc/nginx/http.d

COPY aria2.conf /etc/aria2.conf

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 80 443 6800 6881-6999

ENTRYPOINT ["docker-entrypoint.sh"]