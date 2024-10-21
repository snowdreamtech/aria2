FROM snowdreamtech/debian:12.7.0

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Base Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for Base on Debian. (i386,amd64,arm32v5,arm32v7,arm64,mips64le,ppc64le,s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/aria2" \
    org.opencontainers.image.base.name="snowdreamtech/aria2:debian" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/aria2" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="12.7" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/aria2"

ENV DEBIAN_FRONTEND=noninteractive \
    ARIA2_VERSION=1.37.0+debian-2

RUN set -eux \
    && apt-get -qqy update  \
    && apt-get -qqy install --no-install-recommends \ 
    -t trixie aria2=${ARIA2_VERSION} \     
    && useradd -m -d /var/lib/aria2 -c aria2 -s /usr/sbin/nologin aria2 \        
    && mkdir -p /var/lib/aria2/.aria2  \
    && mkdir -p /var/lib/aria2/downloads  \
    && touch /var/lib/aria2/.aria2/aria2.session  \
    && chown -R aria2:aria2 /var/lib/aria2 \                                                                                                                                                                        
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

COPY aria2.conf /etc/aria2.conf

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 6800 6881-6999

ENTRYPOINT ["docker-entrypoint.sh"]