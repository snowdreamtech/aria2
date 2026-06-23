# Aria2

![Docker Image Version](https://img.shields.io/docker/v/snowdreamtech/aria2)
![Docker Image Size](https://img.shields.io/docker/image-size/snowdreamtech/aria2/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/snowdreamtech/aria2)
![Docker Stars](https://img.shields.io/docker/stars/snowdreamtech/aria2)

Docker Image packaging for Aria2. (amd64, arm32v5, arm32v6, arm32v7, arm64v8, i386, mips64le, ppc64le, riscv64, s390x)

[README](README.md) | [中文文档](README_zh-CN.md)

## Overview

The Docker aria2 image serves as a foundational starting point for building containerized applications. It provides:

- **Standardized Dockerfiles** with OCI annotations and best practices
- **Flexible entrypoint system** supporting custom initialization scripts
- **Consistent environment variable configuration** across all variants
- **Multi-architecture support** for diverse hardware platforms
- **User/group management** with PUID/PGID support for permission handling
- **Three distribution variants**: Alpine (lightweight), Debian (default/widely-compatible), Rocky (enterprise)

## Usage

To help you get started creating a container from this image, you can either use docker-compose or the docker cli.

### Docker Cli

If `RPC_HASH` is not set, it will be generated automatically. You can check it in the docker container logs.

```bash
docker run -d \
  --name=aria2 \
  -e TZ=Asia/Shanghai \
  -p 6800:6800 \
  -p 6881-6999:6881-6999 \
  -v ./downloads:/var/lib/aria2/downloads \
  --restart unless-stopped \
  snowdreamtech/aria2:latest
# snowdreamtech/aria2:alpine
# snowdreamtech/aria2:debian
# snowdreamtech/aria2:rocky
```

### Docker Compose

```yaml
services:
  aria2:
    image: snowdreamtech/aria2:latest
    container_name: aria2
    environment:
      - TZ=Asia/Shanghai
    ports:
      - "6800:6800"
      - "6881-6999:6881-6999"
    volumes:
      - ./downloads:/var/lib/aria2/downloads
    restart: unless-stopped
```

## Distribution Variants

### Debian (Default)

The recommended variant for most use cases, providing wide compatibility and extensive package availability.

```bash
docker run -d \
  --name=aria2 \
  -e TZ=Asia/Shanghai \
  -p 6800:6800 \
  -p 6881-6999:6881-6999 \
  -v ./downloads:/var/lib/aria2/downloads \
  --restart unless-stopped \
  snowdreamtech/aria2:debian
```

**Supported Architectures**: i386, amd64, arm32v5, arm32v7, arm64, mips64le, ppc64le, s390x

**Base Image**: `snowdreamtech/debian:13.5.0`

### Alpine

Lightweight variant optimized for minimal image size and fast startup times.

```bash
docker run -d \
  --name=aria2 \
  -e TZ=Asia/Shanghai \
  -p 6800:6800 \
  -p 6881-6999:6881-6999 \
  -v ./downloads:/var/lib/aria2/downloads \
  --restart unless-stopped \
  snowdreamtech/aria2:alpine
```

**Supported Architectures**: i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x

**Base Image**: `snowdreamtech/alpine:3.24.0`

### Rocky

Enterprise-focused variant based on Rocky Linux, ideal for production environments requiring RHEL compatibility.

```bash
docker run -d \
  --name=aria2 \
  -e TZ=Asia/Shanghai \
  -p 6800:6800 \
  -p 6881-6999:6881-6999 \
  -v ./downloads:/var/lib/aria2/downloads \
  --restart unless-stopped \
  snowdreamtech/aria2:rocky
```

**Supported Architectures**: i386, amd64, arm32v5, arm32v7, arm64, mips64le, ppc64le, s390x

**Base Image**: `snowdreamtech/rocky:10.2.0`

## Build Instructions

### Single Architecture Build

```bash
# Build Debian variant
docker build -t snowdreamtech/aria2:debian ./docker/debian/

# Build Alpine variant
docker build -t snowdreamtech/aria2:alpine ./docker/alpine/

# Build Rocky variant
docker build -t snowdreamtech/aria2:rocky ./docker/rocky/
```

### Multi-Architecture Build

Build images for multiple architectures using `docker buildx`:

```bash
# Create and use a buildx builder
docker buildx create --use --name build --node build --driver-opt network=host

# Build Debian for multiple architectures
docker buildx build \
  --platform=linux/386,linux/amd64,linux/arm/v5,linux/arm/v7,linux/arm64,linux/mips64le,linux/ppc64le,linux/s390x \
  -t snowdreamtech/aria2:debian \
  ./docker/debian/ \
  --push

# Build Alpine for multiple architectures
docker buildx build \
  --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
  -t snowdreamtech/aria2:alpine \
  ./docker/alpine/ \
  --push

# Build Rocky for multiple architectures
docker buildx build \
  --platform=linux/386,linux/amd64,linux/arm/v5,linux/arm/v7,linux/arm64,linux/mips64le,linux/ppc64le,linux/s390x \
  -t snowdreamtech/aria2:rocky \
  ./docker/rocky/ \
  --push
```

## Environment Variables

All variants support the following environment variables for runtime configuration:

| Variable | Default | Description |
|----------|---------|-------------|
| `KEEPALIVE` | `0` | Keep container running (1=enabled, 0=disabled) |
| `CAP_NET_BIND_SERVICE` | `0` | Enable binding to privileged ports (<1024) |
| `LANG` | `C.UTF-8` | Locale setting for UTF-8 character support |
| `UMASK` | `022` | Default file creation mask |
| `DEBUG` | `false` | Enable debug output in entrypoint scripts |
| `PGID` | `0` | Primary group ID for custom user creation |
| `PUID` | `0` | User ID for custom user creation |
| `USER` | `root` | Username for custom user creation |
| `WORKDIR` | `/root` | Working directory path |
| `TZ` | - | Timezone (e.g., `Asia/Shanghai`, `America/New_York`) |
| `RPC_HASH` | - | Custom RPC Secret |

**Debian-specific**:

| Variable | Default | Description |
|----------|---------|-------------|
| `DEBIAN_FRONTEND` | `noninteractive` | Debian package installation mode |

### Custom User Creation

Create a non-root user with specific UID/GID at build time:

```bash
docker build \
  --build-arg PUID=1000 \
  --build-arg PGID=1000 \
  --build-arg USER=appuser \
  -t snowdreamtech/aria2:debian-custom \
  ./docker/debian/
```

Or at runtime (requires rebuilding the image):

```bash
docker run -d \
  --name=aria2 \
  -e PUID=1000 \
  -e PGID=1000 \
  -e USER=appuser \
  snowdreamtech/aria2:debian
```

**Note**: User creation only occurs when `PUID≠0`, `PGID≠0`, and `USER≠root`.

## Semantic Versioning Tags

Images follow semantic versioning with the format: `{major}.{minor}.{patch}-{variant}`

Examples:

- `snowdreamtech/aria2:1.37.0-debian`
- `snowdreamtech/aria2:1.37.0-alpine`
- `snowdreamtech/aria2:1.37.0-rocky`

This format allows:

- **Full version pinning**: `1.37.0-debian` (exact version)
- **Variant latest tag**: `latest-debian` (tracks most recent release for Debian)
- **Global latest tag**: `latest` (tracks most recent release, defaults to Debian)

## Architecture Support

Each distribution variant supports multiple CPU architectures for deployment across diverse hardware platforms:

| Variant | Architectures |
|---------|---------------|
| **Debian** | i386, amd64, arm32v5, arm32v7, arm64, mips64le, ppc64le, s390x |
| **Alpine** | i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x |
| **Rocky** | i386, amd64, arm32v5, arm32v7, arm64, mips64le, ppc64le, s390x |

Docker automatically selects the appropriate architecture for your platform when pulling images.

## Entrypoint System

The base template includes a flexible entrypoint system that executes custom initialization scripts before starting your application.

### How It Works

1. The `docker-entrypoint.sh` script runs at container startup
2. It executes all executable scripts in `/usr/local/bin/entrypoint.d/` in lexical order
3. Each script receives the container's command-line arguments
4. If any script fails, the container stops (fail-fast behavior)

### Debug Mode

Enable debug output to troubleshoot entrypoint execution:

```bash
docker run -e DEBUG=true snowdreamtech/aria2:debian
```

## Reference

1. [使用 buildx 构建多平台 Docker 镜像](https://icloudnative.io/posts/multiarch-docker-with-buildx/)
2. [如何使用 docker buildx 构建跨平台 Go 镜像](https://waynerv.com/posts/building-multi-architecture-images-with-docker-buildx/#buildx-%E7%9A%84%E8%B7%A8%E5%B9%B3%E5%8F%B0%E6%9E%84%E5%BB%BA%E7%AD%96%E7%95%A5)
3. [Building Multi-Arch Images for Arm and x86 with Docker Desktop](https://www.docker.com/blog/multi-arch-images/)
4. [How to Rapidly Build Multi-Architecture Images with Buildx](https://www.docker.com/blog/how-to-rapidly-build-multi-architecture-images-with-buildx/)
5. [Faster Multi-Platform Builds: Dockerfile Cross-Compilation Guide](https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/)
6. [docker/buildx](https://github.com/docker/buildx)

## Contact (备注：aria2)

* Email: <sn0wdr1am@qq.com>
* QQ: 3217680847
* QQ群: 949022145
* WeChat/微信群: sn0wdr1am

## License

MIT
