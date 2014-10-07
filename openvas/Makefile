
all: 
	docker build -t dramaturg/openvas .

run:
	docker run -d -i -t --name=openvas -p 9390:9390 -p 9391:9391 dramaturg/openvas

push:
	docker tag dramaturg/openvas dramaturg/openvas:$$(date +%Y%m%d) 
	docker push dramaturg/openvas

