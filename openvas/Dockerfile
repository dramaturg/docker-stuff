
FROM dramaturg/debian-updated:latest

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>


RUN apt-get -y update ; \
	apt-get -y install libmicrohttpd-dev libxml2-dev libxslt1-dev pkg-config \
		libssh-dev libgnutls-dev libglib2.0-dev libpcap-dev libgpgme11-dev uuid-dev \
		bison libksba-dev libsqlite3-dev doxygen graphviz texlive-latex-extra cmake \
		libldap2-dev xsltproc rsync sqlite3 bzip2 ; \
	apt-get clean

ADD http://wald.intevation.org/frs/download.php/1722/openvas-libraries-7.0.4.tar.gz /root/
ADD http://wald.intevation.org/frs/download.php/1726/openvas-scanner-4.0.3.tar.gz /root/
ADD http://wald.intevation.org/frs/download.php/1730/openvas-manager-5.0.4.tar.gz /root/
ADD http://wald.intevation.org/frs/download.php/1734/greenbone-security-assistant-5.0.3.tar.gz /root/
ADD http://wald.intevation.org/frs/download.php/1633/openvas-cli-1.3.0.tar.gz /root/


RUN mkdir /usr/src/openvas && \
	ls /root/*.tar.gz | xargs -n 1 tar -xzv -C /usr/src/openvas -f
WORKDIR /usr/src/openvas/
RUN for i in \
		openvas-libraries \
		openvas-scanner \
		openvas-manager \
		greenbone-security-assistant \
		openvas-cli ; \
	do \
	( set -e ; \
	  mkdir -p $(echo ${i}*)/build && \
	  cd $(echo ${i}*)/build && \
	  cmake .. && \
	  make && \
	  make doc && \
	  make install && \
	  make clean \
	) ; done ; \
	rm -fr */build ; \
	ldconfig

RUN yes '' | openvas-mkcert -n && \
	openvas-mkcert-client -n -i

RUN openvassd && \
	openvasmd --rebuild && \
	openvas-nvt-sync && \
	openvas-scapdata-sync && \
	openvas-certdata-sync && \
	openvasmd --rebuild --progress && \
	openvasmd --create-user=admin --role=Admin && \
	openvasmd --user=admin --new-password=admin


# openvassd sleep 15
# openvasmd --listen=127.0.0.1 --port=9393
# gsad --port=9390 --mlisten=127.0.0.1 --mport=9393

ADD monit_openvas /etc/monit/conf.d/openvas
EXPOSE 9390 9391

