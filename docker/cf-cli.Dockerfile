FROM alpine:3.5

RUN apk update && apk add curl
WORKDIR /tmp
RUN curl -L "https://cli.run.pivotal.io/stable?release=macosx64-binary&source=github" | tar -zx
RUN mv cf /usr/local/bin
RUN rm *
# clean apk cache
