
FROM dramaturg/debian-updated

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>

ENV DEBIAN_FRONTEND noninteractive
#ENV SETTINGS_FLAVOR test

RUN apt-get -y install git-core build-essential python-dev libevent-dev python-pip libssl-dev liblzma-dev gunicorn python-gevent libffi-dev

WORKDIR /opt
RUN git clone git://github.com/dotcloud/docker-registry.git
ADD config.yml /opt/docker-registry/config/config.yml

WORKDIR /opt/docker-registry
RUN pip install -M -r requirements.txt

CMD ./setup-configs.sh && ./run.sh

EXPOSE 5000

