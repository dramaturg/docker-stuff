
FROM dramaturg/debian-fluentd:latest

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>

RUN curl -s http://packages.elasticsearch.org/GPG-KEY-elasticsearch |\
		apt-key add - && \
    echo deb http://packages.elasticsearch.org/elasticsearch/1.5/debian \
		stable main > /etc/apt/sources.list.d/elasticsearch.list && \
    echo deb http://packages.elasticsearch.org/logstash/1.5/debian \
		stable main > /etc/apt/sources.list.d/logstash.list

RUN apt-get -y update && \
	apt-get -y install elasticsearch openjdk-7-jre-headless tzdata-java/testing && \
	apt-get clean

WORKDIR /opt
RUN curl -OL https://download.elastic.co/kibana/kibana/kibana-4.0.2-linux-x64.tar.gz && \
	tar xzf kibana-*.tar.gz && rm kibana-*.tar.gz && \
	ln -s kibana-* kibana && \
	sed -i '${s/$/ \&/}' /opt/kibana/bin/kibana

# plugins
RUN /usr/share/elasticsearch/bin/plugin --install elasticsearch/elasticsearch-mapper-attachments/2.0.0 && \
    /usr/share/elasticsearch/bin/plugin --install polyfractal/elasticsearch-inquisitor
#RUN /usr/share/elasticsearch/bin/plugin --install river-csv \
#	-u https://github.com/AgileWorksOrg/elasticsearch-river-csv/releases/download/2.0.1/elasticsearch-river-csv-2.0.1.zip
#RUN /usr/share/elasticsearch/bin/plugin --install com.bazoud.elasticsearch/elasticsearch-river-git/0.0.2
#RUN /usr/share/elasticsearch/bin/plugin --install tlrx/elasticsearch-river-ldap/0.0.2
#RUN /usr/share/elasticsearch/bin/plugin --install river-imap \
#	-u http://dl.bintray.com/salyh/maven/de/saly/elasticsearch/plugin/elasticsearch-river-imap/0.0.7-b12/elasticsearch-river-imap-0.0.7-b12-plugin.zip
#RUN /usr/share/elasticsearch/bin/plugin --install fr.pilato.elasticsearch.river/rssriver/0.2.0

# # Elasticsearch shield
# RUN /usr/share/elasticsearch/bin/plugin --install elasticsearch/license/latest && \
#     /usr/share/elasticsearch/bin/plugin --install bin/plugin -i elasticsearch/shield/latest && \
#     /usr/share/elasticsearch/bin/shield/esusers useradd admin -r admin -p password && \
#     /usr/share/elasticsearch/bin/shield/esusers useradd reader -r user -p reader

# management
RUN /usr/share/elasticsearch/bin/plugin --install lmenezes/elasticsearch-kopf && \
    /usr/share/elasticsearch/bin/plugin --install lukas-vlcek/bigdesk && \
    /usr/share/elasticsearch/bin/plugin --install royrusso/elasticsearch-HQ
#RUN /usr/share/elasticsearch/bin/plugin --install mobz/elasticsearch-head


ADD monit_elasticsearch /etc/monit/conf.d/elasticsearch
EXPOSE 9200
EXPOSE 9300

ADD monit_kibana /etc/monit/conf.d/kibana
EXPOSE 5601


## configuration
ENV cluster_name elasticsearch
ENV conff_elasticsearch /etc/elasticsearch/elasticsearch.yml

RUN sed -i '/#\(cluster\.name: \).*/{s//\1 %%cluster_name%%/}' \
		/etc/elasticsearch/elasticsearch.yml
ADD fluentd_out_elasticsearch.conf /etc/td-agent/out_50_elasticsearch.conf
RUN td-agent-gem install fluent-plugin-elasticsearch

# fix for broken init script
USER elasticsearch
RUN mkdir -p /var/lib/elasticsearch/elasticsearch/nodes &&\
    chmod -R 755 /var/lib/elasticsearch/
USER root
RUN sed -i -e 's/^#\(START_DAEMON\)/\1/' /etc/default/elasticsearch && \
    sed -i '/sysctl/{s/^.*$/sleep .1/}' /etc/init.d/elasticsearch && \
    echo setfacl -R -m \
	u::rwx,u:elasticsearch:rwx,d:u:elasticsearch:rwx,d:g:elasticsearch:rwx \
	/var/lib/elasticsearch >> /root/configurator.sh

