FROM ruby
RUN gem install fpm
WORKDIR /work
ARG VERSION=0.15.0
ADD https://releases.hashicorp.com/consul-template/0.15.0/consul-template_${VERSION}_linux_amd64.zip amd64.zip
RUN apt-get update && apt-get install -yq unzip
RUN unzip amd64.zip
RUN fpm -s dir -t deb -n consul-template -v $VERSION --prefix usr/bin/ consul-template
RUN dpkg --contents *.deb
RUN mkdir /dist && mv *.deb /dist/

