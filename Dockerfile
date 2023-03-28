FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
  && apt install -y \
     ca-certificates \
     curl \
     wget \
     git \
     jq \
     xz-utils \
     libicu-dev \
  && rm -rf /var/lib/apt/lists/*

ENV DOCKER_PATH=/usr/bin/docker
ENV PATH="$DOCKER_PATH:$PATH"

RUN mkdir -p $DOCKER_PATH \
  && wget -q -O /tmp/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-20.10.23.tgz \
  && tar --extract --file /tmp/docker.tgz --directory $DOCKER_PATH --strip-components 1 --no-same-owner \
  && rm -rf /tmp/*

RUN mkdir -p /usr/lib/docker/cli-plugins \
  && wget -q -O /usr/lib/docker/cli-plugins/docker-buildx https://github.com/docker/buildx/releases/download/v0.10.4/buildx-v0.10.4.linux-amd64 \
  && chmod +x /usr/lib/docker/cli-plugins/docker-buildx

ENV NODE_PATH=/usr/bin/nodejs
ENV PATH="$NODE_PATH/bin:$PATH"

RUN mkdir -p $NODE_PATH \
  && wget -q -O /tmp/nodejs.tar.xz https://nodejs.org/dist/v18.15.0/node-v18.15.0-linux-x64.tar.xz \
  && tar --extract --file /tmp/nodejs.tar.xz --directory $NODE_PATH --strip-components 1 --no-same-owner \
  && rm -rf /tmp/* \
  && npm install -g npm \
  && npm install -g yarn