FROM snowdreamtech/alpine:3.20.0

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

RUN apk add --no-cache nginx \
    aria2 \
    aria2-daemon \
    aria2-bash-completion \
    aria2-doc \
    && mkdir -p /var/lib/aria2/  \
    && touch /var/lib/aria2/aria2.session

COPY http.d /etc/nginx/http.d

COPY dist /var/lib/nginx/html

COPY aria2.conf /etc/aria2.conf

EXPOSE 80 443 6800 6881-6999

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]