
FROM dramaturg/debian-fluentd:latest

ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>


## installation graylog2
RUN apt-get -y install procps apt-transport-https && \
	apt-key adv --keyserver pool.sks-keyservers.net --recv-keys D44C1D8DB1606F22

ADD graylog2.list /etc/apt/sources.list.d/
RUN apt-get -y update && \
	apt-get -y install graylog2-server graylog2-web && \
	apt-get clean


## configuring fluentd for graylog output
ADD fluentd.conf_gelfout /etc/td-agent/out_90_alltograylog.conf
RUN td-agent-gem install gelf
ADD https://raw.githubusercontent.com/emsearcy/fluent-plugin-gelf/master/lib/fluent/plugin/out_gelf.rb /etc/td-agent/plugin/
RUN chmod 644 /etc/td-agent/plugin/*


## configuration graylog2
# mkpasswd -l 96
ENV password_secret znyblczfttldesgwjgsgxutujoSacomlagxelcskfkftyevrqv75wocbgvbmzkK
# echo -n foobar | shasum -a 256
ENV root_password_sha2 c3ab8ff13720e8ad9047dd39466b3c8974e592c2fa383d4a3960714caef0c4f2
ENV application_secret cyuDw6VF1s52qDR7PKLY1tNOLSEGMqmATxitsC
ENV elasticsearch_shards 1
ENV elasticsearch_replicas 0
ENV elasticsearch_cluster_name elasticsearch
ENV elasticsearch_discovery_zen_ping_multicast_enabled true
ENV graylog2-server_uris "http://127.0.0.1:12900/"

# template the config files
RUN sed -i \
		-e '/password_secret/{s/[^= ]*$/ %%password_secret%%/}' \
		-e '/root_password_sha2/{s/[^= ]*$/ %%root_password_sha2%%/}' \
		-e '/mongodb_host/{s/[^= ]*$/ %%MONGODB_PORT_27017_TCP_ADDR%%/}' \
		-e '/elasticsearch_shards/{s/[^= ]*$/ %%elasticsearch_shards%%/}' \
		-e '/elasticsearch_replicas/{s/[^= ]*$/ %%elasticsearch_replicas%%/}' \
		-e '/elasticsearch_cluster_name/{ \
			s/^#//; s/[^= ]*$/ %%elasticsearch_cluster_name%%/}' \
		-e '/elasticsearch_discovery_zen_ping_multicast_enabled/{ \
			s/^#//; s/[^= ]*$/ %%elasticsearch_discovery_zen_ping_multicast_enabled%%/}' \
		-e '/elasticsearch_discovery_zen_ping_unicast_hosts/{ \
			s/^#//; s/[^= ]*$/ %%ELASTICSEARCH_PORT_9300_TCP_ADDR%%/}' \
		/etc/graylog2.conf && \
	sed -i \
		-e '/graylog2-server.uris/{s/[^= ]*$/%%graylog2-server_uris%%/}' \
		-e '/application.secret/{s/[^= ]*$/%%application_secret%%/}' \
		/etc/graylog2/web/graylog2-web-interface.conf
ENV conff_graylog /etc/graylog2.conf
ENV conff_graylog-web /etc/graylog2/web/graylog2-web-interface.conf
ADD monit_graylog2 /etc/monit/conf.d/graylog2
EXPOSE 9000 12201 12201/udp 12900


