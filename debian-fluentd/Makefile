
all: 
	docker build -t dramaturg/debian-fluentd .

push:
	docker tag dramaturg/debian-fluentd dramaturg/debian-fluentd:$$(date +%Y%m%d)
	docker push dramaturg/debian-fluentd

run:
	docker run -d -i -t \
		-v /tmp:/t \
		-p 514:5014 -p 514:5014/udp -p 8888:8888 \
		-p 24224:24224 -p 24224:24224/udp \
		--name=debian-fluentd \
		dramaturg/debian-fluentd

