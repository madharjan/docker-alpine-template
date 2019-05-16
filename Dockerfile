FROM alpine:3.9
MAINTAINER Madhav Raj Maharjan <madhav.maharjan@gmail.com>

ARG VCS_REF
ARG ALPINE_VERSION
ARG DEBUG=false

LABEL description="Docker container woth Tools" os_version="Alpine ${ALPINE_VERSION}" \
      org.label-schema.vcs-ref=${VCS_REF} org.label-schema.vcs-url="https://github.com/madharjan/docker-tools"

ENV ALPINE_VERSION ${ALPINE_VERSION}

RUN \
  adduser -h /home -s /sbin/nologin -D alpine && \
  apk add --update --no-cache htop && \
  rm -f /tmp/* /etc/apk/cache/* /var/cache/apk/*

USER alpine

WORKDIR /home

ENTRYPOINT ["htop"]

ENTRYPOINT ["/bin/sh"]