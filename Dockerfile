FROM alpine:3.9
MAINTAINER Madhav Raj Maharjan <madhav.maharjan@gmail.com>

ARG VCS_REF
ARG TEMPLATE_VERSION
ARG DEBUG=false

LABEL description="Docker container with Tools" os_version="Alpine 3.4" \
      org.label-schema.vcs-ref=${VCS_REF} org.label-schema.vcs-url="https://github.com/madharjan/docker-tools"

ENV HOME /root
ENV ALPINE_VERSION 3.4
ENV TEMPLATE_VERSION ${TEMPLATE_VERSION}

RUN mkdir -p /build
COPY . /build

RUN chmod 755 /build/scripts/*.sh && /build/scripts/install.sh && /build/scripts/cleanup.sh

WORKDIR /root

ENTRYPOINT ["/docker-entrypoint.sh"]
