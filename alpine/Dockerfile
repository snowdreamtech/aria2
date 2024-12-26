FROM snowdreamtech/alpine:3.21.0

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Aria2 Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for Aria2 on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/aria2" \
    org.opencontainers.image.base.name="snowdreamtech/aria2:alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/aria2" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="1.37.0" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/aria2"

# keep the docker container running
ENV KEEPALIVE=1 \
    ARIA2_VERSION=1.37.0-r0

ARG GID=1000 \
    UID=1000  \
    USER=aria2 \
    WORKDIR=/var/lib/aria2

# Create a user with UID and GID
RUN if [ "${USER}" != "root" ]; then \
    addgroup -g ${GID} ${USER}; \
    adduser -h ${WORKDIR} -u ${UID} -g ${USER} -G ${USER} -s /usr/sbin/nologin -D ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi

RUN apk add --no-cache aria2-daemon=${ARIA2_VERSION} \
    && mkdir -p /var/lib/aria2/.aria2  \
    && mkdir -p /var/lib/aria2/downloads  \
    && touch /var/lib/aria2/.aria2/aria2.session  \
    && chown -R ${USER}:${USER} /var/lib/aria2

# Switch to the user
USER ${USER}

# Set the workdir
WORKDIR ${WORKDIR}

COPY aria2.conf /etc/aria2.conf

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 6800 6881-6999

ENTRYPOINT ["docker-entrypoint.sh"]