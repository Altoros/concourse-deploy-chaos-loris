FROM alpine:3.5

RUN apk update && apk add curl bash
WORKDIR /tmp
RUN curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.23.1&source=github-rel" | tar -zx
RUN mv cf /usr/local/bin
RUN chmod +x /usr/local/bin/cf
RUN curl -L -o vault.zip "https://releases.hashicorp.com/vault/0.6.4/vault_0.6.4_linux_amd64.zip"
RUN unzip vault.zip
RUN mv vault /usr/local/bin
RUN chmod +x /usr/local/bin/vault
RUN rm *

# clean apk cache
