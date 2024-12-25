FROM snowdreamtech/debian:12.8.0

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Aria2 Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for Aria2 on Debian. (i386,amd64,arm32v5,arm32v7,arm64,mips64le,ppc64le,s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/aria2" \
    org.opencontainers.image.base.name="snowdreamtech/aria2:debian" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/aria2" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="1.36.0" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/aria2"

ENV DEBIAN_FRONTEND=noninteractive \
    KEEPALIVE=1 \
    ARIA2_VERSION=1.36.0-1

ARG GID=1000 \
    UID=1000  \
    USER=aria2 \
    WORKDIR=/var/lib/aria2

# Create a user with UID and GID
RUN set -eux \
    &&if [ "${USER}" != "root" ]; then \
    addgroup --gid ${GID} ${USER}; \
    adduser --home ${WORKDIR} --uid ${UID} --gid ${GID} --gecos ${USER} --shell /usr/sbin/nologin --disabled-password ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi \
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* 

RUN set -eux \
    && apt-get -qqy update  \
    && apt-get -qqy install --no-install-recommends \ 
    aria2=${ARIA2_VERSION} \     
    && mkdir -p /var/lib/aria2/.aria2  \
    && mkdir -p /var/lib/aria2/downloads  \
    && touch /var/lib/aria2/.aria2/aria2.session  \
    && chown -R ${USER}:${USER} /var/lib/aria2 \                                                                                                                                                                        
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Switch to the user
USER ${USER}

# Set the workdir
WORKDIR ${WORKDIR}

COPY aria2.conf /etc/aria2.conf

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 6800 6881-6999

ENTRYPOINT ["docker-entrypoint.sh"]