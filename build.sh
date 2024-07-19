#!/bin/sh

DOCKER_HUB_PROJECT=snowdreamtech/aria2

GITHUB_PROJECT=ghcr.io/snowdreamtech/aria2

docker buildx build --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
    -t ${DOCKER_HUB_PROJECT}:ariang-latest \
    -t ${DOCKER_HUB_PROJECT}:ariang-1.37.0 \
    -t ${DOCKER_HUB_PROJECT}:ariang-1.37 \
    -t ${DOCKER_HUB_PROJECT}:ariang-1 \
    -t ${GITHUB_PROJECT}:ariang-latest \
    -t ${GITHUB_PROJECT}:ariang-1.37.0 \
    -t ${GITHUB_PROJECT}:ariang-1.37 \
    -t ${GITHUB_PROJECT}:ariang-1 \
    . \
    --push
