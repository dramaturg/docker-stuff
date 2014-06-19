
FROM dramaturg/debian-updated

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>

RUN curl -s http://packages.elasticsearch.org/GPG-KEY-elasticsearch |\
		apt-key add -
RUN echo deb http://packages.elasticsearch.org/elasticsearch/1.2/debian \
		stable main > /etc/apt/sources.list.d/knot.list

RUN apt-get -y update && \
	apt-get -y install elasticsearch openjdk-7-jre-headless tzdata-java/jessie && \
	apt-get clean

# plugins
RUN /usr/share/elasticsearch/bin/plugin --install elasticsearch/elasticsearch-mapper-attachments/2.0.0
#RUN /usr/share/elasticsearch/bin/plugin --install river-csv \
#	-u https://github.com/AgileWorksOrg/elasticsearch-river-csv/releases/download/2.0.1/elasticsearch-river-csv-2.0.1.zip
#RUN /usr/share/elasticsearch/bin/plugin --install com.bazoud.elasticsearch/elasticsearch-river-git/0.0.2
#RUN /usr/share/elasticsearch/bin/plugin --install tlrx/elasticsearch-river-ldap/0.0.2
#RUN /usr/share/elasticsearch/bin/plugin --install river-imap \
#	-u http://dl.bintray.com/salyh/maven/de/saly/elasticsearch/plugin/elasticsearch-river-imap/0.0.7-b12/elasticsearch-river-imap-0.0.7-b12-plugin.zip
#RUN /usr/share/elasticsearch/bin/plugin --install fr.pilato.elasticsearch.river/rssriver/0.2.0


# management
RUN /usr/share/elasticsearch/bin/plugin --install lmenezes/elasticsearch-kopf
RUN /usr/share/elasticsearch/bin/plugin --install lukas-vlcek/bigdesk
RUN /usr/share/elasticsearch/bin/plugin --install royrusso/elasticsearch-HQ
RUN /usr/share/elasticsearch/bin/plugin --install mobz/elasticsearch-head
ADD monit_elasticsearch /etc/monit/conf.d/elasticsearch

EXPOSE 9200
EXPOSE 9300
CMD sed -i '/#\(cluster\.name: \).*/{s//\1 '"$HOSTNAME"'/}' \
		/etc/elasticsearch/elasticsearch.yml && \
		monit -I -v

