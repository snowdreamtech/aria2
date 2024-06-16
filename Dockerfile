FROM snowdreamtech/alpine:3.20.0

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

RUN apk add --no-cache aria2 \
    aria2-daemon \
    aria2-bash-completion \
    aria2-doc \
    && mkdir -p /var/lib/aria2/  \
    && touch /var/lib/aria2/aria2.session

COPY aria2.conf /etc/aria2.conf

EXPOSE 6800 6881-6999

ENTRYPOINT ["/usr/bin/aria2c"]

CMD ["--conf-path", "/etc/aria2.conf"]
