FROM snowdreamtech/alpine:3.20.2

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV ARIANG_VERSION=1.3.7

RUN apk add --no-cache nginx \
    aria2-daemon=1.37.0-r0	 \
    && mkdir -p /var/lib/aria2/.aria2  \
    && touch /var/lib/aria2/.aria2/aria2.session  \
    && chown -R aria2:aria2 /var/lib/aria2/.aria2 \
    && wget -c https://github.com/mayswind/AriaNg/releases/download/${ARIANG_VERSION}/AriaNg-${ARIANG_VERSION}.zip \
    && unzip -o -d /var/lib/nginx/html AriaNg-${ARIANG_VERSION}.zip  \
    && rm -rfv AriaNg-${ARIANG_VERSION}.zip

COPY http.d /etc/nginx/http.d

COPY aria2.conf /etc/aria2.conf

EXPOSE 80 443 6800 6881-6999

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]