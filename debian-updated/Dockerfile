
FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>


RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install apt-utils lsb-release curl git
RUN apt-get clean

# add grml repositories
ADD grml.list /etc/apt/sources.list.d/grml.list
RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-keys F61E2E7CECDEA787

# pin stable repositories
ADD preferences /etc/apt/preferences
ADD grml.pref /etc/apt/preferences.d/grml

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y -o Dpkg::Options::=--force-confdef \
	install grml-etc grml-scripts
RUN apt-get clean

