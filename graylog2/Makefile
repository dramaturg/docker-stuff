
all: 
	docker build -t dramaturg/graylog .

push:
	docker tag dramaturg/graylog dramaturg/graylog:$$(date +%Y%m%d)
	docker push dramaturg/graylog

run:
	docker run -d -i -t \
		-v /tmp:/t \
		-p 12900:12900 -p 9000:9000 \
		-p 514:5014 -p 514:5014/udp -p 8888:8888 \
		-p 24224:24224 -p 24224:24224/udp \
		-p 12201:12201 -p 12201:12201/udp \
		--link mongodb:mongodb \
		--link elasticsearch:elasticsearch \
		--name=graylog \
		dramaturg/graylog

