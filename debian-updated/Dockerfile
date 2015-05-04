
FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>

# clean out, update and install some base utilities
#RUN apt-get -y remove exim4-base exim4-config
RUN apt-get -y update && apt-get -y upgrade && apt-get clean
RUN apt-get -y install apt-utils lsb-release curl git cron at logrotate rsyslog \
	monit unattended-upgrades ssmtp lsof procps && apt-get clean


# add contrib, non-free and backports repositories
ADD sources.list /etc/apt/sources.list


# add grml repositories
ADD grml.list /etc/apt/sources.list.d/grml.list
RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-keys F61E2E7CECDEA787


# pin stable repositories
ADD preferences /etc/apt/preferences
ADD grml.pref /etc/apt/preferences.d/grml

RUN apt-get -y update && apt-get -y upgrade && apt-get clean
RUN apt-get -y -o Dpkg::Options::="--force-confnew" \
	install grml-etc grml-scripts && apt-get clean


# set random root password
RUN P="$(dd if=/dev/random bs=1 count=8 2>/dev/null | base64)" ; echo $P && echo "root:$P" | chpasswd
# set to foobar
#RUN P="foobar" ; echo $P && echo "root:$P" | chpasswd
RUN chsh -s /bin/zsh root


# unattended upgrades & co
ADD apt_unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
ADD apt_periodic /etc/apt/apt.conf.d/02periodic


# service management with monit
RUN cd /etc/monit/conf.d/ && \
	echo "set httpd port 2812 allow 172.16.0.0/12" > monit_httpd && \
	ln -s ../monitrc.d/cron && \
	ln -s ../monitrc.d/at && \
	ln -s ../monitrc.d/rsyslog


# run stuff
ADD configurator.sh /root/
ENTRYPOINT bash /root/configurator.sh && /etc/init.d/monit start && /bin/zsh
CMD /bin/zsh

