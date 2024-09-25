FROM snowdreamtech/build-essential:alpine3.20 AS builder

ENV ARIA2_VERSION=1.37.0

RUN mkdir /workspace

WORKDIR /workspace

RUN wget -c https://github.com/aria2/aria2/archive/refs/tags/release-${ARIA2_VERSION}.tar.gz \
    && tar zxvf release-${ARIA2_VERSION}.tar.gz \
    && cd aria2-release-${ARIA2_VERSION} \
    && autoreconf -i \
    && ./configure ARIA2_STATIC=yes --without-gnutls --with-openssl \
    && make \
    && cp -rfv bin conf /workspace/ 



# FROM snowdreamtech/alpine:3.20.3

# # OCI annotations to image
# LABEL org.opencontainers.image.authors="Snowdream Tech" \
#     org.opencontainers.image.title="Base Image Based On Alpine" \
#     org.opencontainers.image.description="Docker Images for Base on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
#     org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/aria2" \
#     org.opencontainers.image.base.name="snowdreamtech/aria2:alpine" \
#     org.opencontainers.image.licenses="MIT" \
#     org.opencontainers.image.source="https://github.com/snowdreamtech/aria2" \
#     org.opencontainers.image.vendor="Snowdream Tech" \
#     org.opencontainers.image.version="3.20.3" \
#     org.opencontainers.image.url="https://github.com/snowdreamtech/aria2"

# ENV ARIA2_VERSION=1.37.0-r0

# RUN apk add --no-cache aria2-daemon=${ARIA2_VERSION} \
#     && mkdir -p /var/lib/aria2/.aria2  \
#     && touch /var/lib/aria2/.aria2/aria2.session  \
#     && chown -R aria2:aria2 /var/lib/aria2/.aria2

# COPY aria2.conf /etc/aria2.conf

# COPY docker-entrypoint.sh /usr/local/bin/

# EXPOSE 6800 6881-6999

# ENTRYPOINT ["docker-entrypoint.sh"]