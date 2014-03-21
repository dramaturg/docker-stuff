
FROM dramaturg/debian-updated:testing

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>

RUN apt-get -y update
RUN apt-get -y install redis-server


EXPOSE 6379

CMD /etc/init.d/redis-server start ; while [ -e /proc/$(cat /var/run/redis/redis-server.pid) ] ; do sleep 1 ; done


