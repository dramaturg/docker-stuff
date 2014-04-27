
FROM dramaturg/debian-updated

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>


#RUN echo deb http://www.deb-multimedia.org $(lsb_release -sc) main non-free \
#		> /etc/apt/sources.list.d/deb-multimedia.list
RUN apt-key adv --keyserver eu.pool.sks-keyservers.net \
		--recv-keys E639BFCB72740199
RUN echo deb http://shell.ninthgate.se/packages/debian $(lsb_release -sc) main \
		> /etc/apt/sources.list.d/plex.list
RUN apt-get -y update
RUN apt-get -y install procps avahi-autoipd plexmediaserver


EXPOSE 32400 32443
ADD run_pms /root/run_pms
RUN chmod 755 /root/run_pms
CMD /root/run_pms

