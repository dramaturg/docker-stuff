
FROM dramaturg/debian-updated:latest

ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>


## installation fluentd
RUN curl -s http://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
RUN echo "deb [arch=amd64] http://packages.treasuredata.com/2/debian/wheezy/ wheezy contrib" \
		> /etc/apt/sources.list.d/fluentd.list

RUN dpkg --add-architecture i386 && \
	apt-get -y update && \
	apt-get -y install td-agent build-essential libcurl4-gnutls-dev && \
	apt-get clean

RUN mv /etc/td-agent/td-agent.conf /etc/td-agent/td-agent.conf.bak
RUN td-agent-gem install fluent-plugin-secure-forward

## configuration fluentd
ADD fluentd.conf /etc/td-agent/td-agent.conf
ADD fluentd.conf.d/ /etc/td-agent/
ADD monit_fluentd /etc/monit/conf.d/fluentd
ADD logrotate_td-agent /etc/logrotate.d/td-agent
EXPOSE 24224/tcp 24224/udp 8888/tcp 5014/udp 5014/tcp

