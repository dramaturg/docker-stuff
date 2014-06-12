
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
ADD monit_elasticsearch /etc/monit/conf.d/elasticsearch

EXPOSE 9200
EXPOSE 9300
CMD sed -i '/#\(cluster\.name: \).*/{s//\1 '"$HOSTNAME"'/}' \
		/etc/elasticsearch/elasticsearch.yml && \
		monit -I -v

