FROM snowdreamtech/build-essential:alpine3.20 AS builder

ENV ARIA2_VERSION=1.37.0

RUN mkdir /workspace

WORKDIR /workspace

RUN wget -c https://github.com/aria2/aria2/archive/refs/tags/release-${ARIA2_VERSION}.tar.gz \
    && tar zxvf release-${ARIA2_VERSION}.tar.gz \
    && cd aria2-release-${ARIA2_VERSION} \
    && autoreconf -i \
    && ./configure --with-ca-bundle='/etc/ssl/certs/ca-certificates.crt' OPENSSL_LIBS='-lssl -ldl -lcrypto -ldl -lpthread' --with-openssl --without-gnutls --with-libexpat --without-libxml2 ARIA2_STATIC=yes \
    && make \
    && cp -rfv ./src/aria2c /workspace/ 




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


RUN addgroup -S aria2 2>/dev/null \
    && adduser -S -D -H -h /var/lib/aria2 -s /sbin/nologin -G aria2 \
    -g 'aria2' aria2 2>/dev/null \
    && mkdir -p /var/lib/aria2/.aria2  \
    && touch /var/lib/aria2/.aria2/aria2.session  \
    && chown -R aria2:aria2 /var/lib/aria2/.aria2

COPY --from=builder /workspace/aria2c /usr/bin/

COPY aria2.conf /etc/aria2.conf

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 6800 6881-6999

ENTRYPOINT ["docker-entrypoint.sh"]