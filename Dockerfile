FROM ruby
RUN gem install fpm
RUN apt-get update && apt-get install -yq unzip
WORKDIR /work

ARG VERSION
ARG DEB_ARCH
ARG HASHI_ARCH

ADD https://releases.hashicorp.com/consul-template/${VERSION}/consul-template_${VERSION}_linux_${HASHI_ARCH}.zip consul-template.zip
RUN unzip consul-template.zip
RUN fpm -s dir -t deb -n consul-template -v $VERSION --prefix usr/bin/ -a $DEB_ARCH consul-template
RUN mkdir /dist && mv *.deb /dist/

