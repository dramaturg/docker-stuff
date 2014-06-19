
all: 
	docker build -t dramaturg/elasticsearch .

push:
	docker tag dramaturg/elasticsearch dramaturg/elasticsearch:$$(date +%Y%m%d) 
	docker push dramaturg/elasticsearch

run:
	docker run -d -i -t --name=elasticsearch -p 9200:9200 dramaturg/elasticsearch

