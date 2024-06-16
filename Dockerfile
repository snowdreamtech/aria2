FROM alpine:3.20.0

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

RUN apk add --no-cache musl-locales \
    musl-locales-lang \
    tzdata
