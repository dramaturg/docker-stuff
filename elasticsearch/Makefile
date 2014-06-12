
all: 
	docker build -t dramaturg/elasticsearch .

push:
	docker push dramaturg/elasticsearch

run:
	docker run -d -i -t --name=elasticsearch -p 9200:9200 dramaturg/elasticsearch

