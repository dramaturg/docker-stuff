
FROM dramaturg/debian-updated

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>

ADD apt_linuxmint /etc/apt/sources.list.d/linuxmint.list
RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-keys 3EE67F3D0FF405B2 07DC563D1F41B907

RUN apt-get -y update && \
    apt-get -y install openjdk-7-jre-headless tzdata-java/testing p7zip-full && \
	apt-get clean
RUN apt-get -y install -t testing ffmpeg rtmpdump && apt-get clean

ADD VODServer-1.3-bin.zip /tmp/
WORKDIR /opt
RUN 7z x /tmp/VODServer*.zip
RUN ln -s /opt/VOD* /opt/vodserver
RUN sed -i 's/127.0.0.1/0.0.0.0/' /opt/vodserver/vodserver-jetty.xml
ADD monit_vodserver /etc/monit/conf.d/vodserver

EXPOSE 9999

