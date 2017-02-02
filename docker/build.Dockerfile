FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install default-jdk maven ruby
RUN gem install bundler
RUN apt-get install -y golang
RUN rm -rf /var/lib/apt/lists/*
