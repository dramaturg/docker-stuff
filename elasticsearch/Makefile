
all: 
	docker build -t dramaturg/elasticsearch .

push:
	docker tag dramaturg/elasticsearch dramaturg/elasticsearch:$$(date +%Y%m%d) 
	docker push dramaturg/elasticsearch

run:
	docker run -d -i -t --name=elasticsearch \
		-p 9200:9200 -p 9300:9300 -p 5601:5601 -p 24224:24224 \
		dramaturg/elasticsearch

