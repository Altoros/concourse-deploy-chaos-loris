FROM agf234/bosh-tools-awscli
MAINTAINER Alexander Lomov <alexander.lomov@altoros.com>

RUN curl -L "https://cli.run.pivotal.io/stable?release=macosx64-binary&source=github" | tar -zx
RUN mv cf /usr/local/bin
RUN echo "export PATH=\$PATH:/usr/local/bin/:" >> ~/.bashrc

# install CF 
