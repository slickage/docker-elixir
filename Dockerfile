FROM alpine:latest
MAINTAINER James Wang <jw@slickage.com>

ENV REFRESHED_AT 2016-11-24
ENV ELIXIR_VERSION 1.3.4
ENV HOME /root

# Erlang, depdendencies, Elixir
RUN apk --update add erlang
RUN apk --update add --virtual .build-dependencies \
  ca-certificates \
  openssl \
  wget \
  && rm -rf /var/cache/apk/*
RUN wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
  mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
  unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
  rm Precompiled.zip && \
  rm -rf /var/cache/apk/*

RUN apk del .build-dependencies

# Add local node module binaries to PATH
ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

CMD ["/bin/sh"]
