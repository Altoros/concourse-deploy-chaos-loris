FROM agf234/bosh-tools-awscli
MAINTAINER Alexander Lomov <alexander.lomov@altoros.com>

#RUN apt-get update
RUN apt-get -y install default-jre maven 
RUN gem install bundler
# you need to have java, mvn, ruby, bundler
