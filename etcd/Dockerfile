
FROM debian:testing

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install apt-utils lsb-release curl
RUN apt-get -y install git golang


WORKDIR /opt
RUN git clone https://github.com/coreos/etcd
WORKDIR /opt/etcd
RUN ./build

VOLUME ["/etcd"]
CMD /opt/etcd/bin/etcd -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0 -data-dir /etcd -name $HOSTNAME

EXPOSE 4001 7001

