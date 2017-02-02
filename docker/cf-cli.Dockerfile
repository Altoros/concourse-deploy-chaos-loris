FROM alpine:3.5

RUN apk update && apk add curl bash
WORKDIR /tmp
RUN curl -L "https://cli.run.pivotal.io/stable?release=macosx64-binary&source=github" | tar -zx
RUN mv cf /usr/local/bin
RUN chmod +x /usr/local/bin/cf
RUN rm *
# clean apk cache
