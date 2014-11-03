
FROM dramaturg/debian-updated

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>

RUN curl -s http://packages.elasticsearch.org/GPG-KEY-elasticsearch |\
		apt-key add -
RUN echo deb http://packages.elasticsearch.org/elasticsearch/1.4/debian \
		stable main > /etc/apt/sources.list.d/elasticsearch.list
RUN echo deb http://packages.elasticsearch.org/logstash/1.4/debian \
		stable main > /etc/apt/sources.list.d/logstash.list

RUN curl -s http://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
RUN echo "deb http://packages.treasuredata.com/2/debian/wheezy/ wheezy contrib" \
		> /etc/apt/sources.list.d/fluentd.list

RUN apt-get -y update && \
	apt-get -y install elasticsearch openjdk-7-jre-headless \
		td-agent build-essential libcurl4-gnutls-dev&& \
	apt-get clean

WORKDIR /opt
RUN curl -OL https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-BETA1.1.tar.gz && \
	tar xzf kibana-*.tar.gz && rm kibana-*.tar.gz && \
	ln -s kibana-* kibana && \
	sed -i '${s/$/ \&/}' /opt/kibana/bin/kibana

# plugins
RUN /usr/share/elasticsearch/bin/plugin --install elasticsearch/elasticsearch-mapper-attachments/2.0.0
RUN /usr/share/elasticsearch/bin/plugin --install polyfractal/elasticsearch-inquisitor
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

ADD monit_kibana /etc/monit/conf.d/kibana
EXPOSE 5601


# fluentd
RUN mv /etc/td-agent/td-agent.conf /etc/td-agent/td-agent.conf.bak
RUN td-agent-gem install fluent-plugin-secure-forward
RUN td-agent-gem install fluent-plugin-elasticsearch
RUN td-agent-gem install fluent-plugin-parser
RUN td-agent-gem install fluent-plugin-rewrite-tag-filter

ADD monit_fluentd /etc/monit/conf.d/fluentd
ADD fluentd.conf /etc/td-agent/td-agent.conf
EXPOSE 8888
EXPOSE 9880
EXPOSE 24224/tcp 24224/udp
EXPOSE 5014/tcp 5014/udp


CMD sed -i '/#\(cluster\.name: \).*/{s//\1 '"$HOSTNAME"'/}' \
		/etc/elasticsearch/elasticsearch.yml && \
		monit -I -v

