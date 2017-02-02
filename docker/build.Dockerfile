FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install default-jdk maven ruby ruby-dev zlib1g-dev liblzma-dev nodejs
RUN gem install bundler
RUN apt-get install -y golang
RUN rm -rf /var/lib/apt/lists/*
