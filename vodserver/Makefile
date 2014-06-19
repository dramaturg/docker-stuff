
all:
	docker build -t dramaturg/vodserver .

push:
	docker tag dramaturg/vodserver dramaturg/vodserver:$$(date +%Y%m%d) 
	docker push dramaturg/vodserver

run:
	docker run -t -i -d -p 9999:9999 dramaturg/vodserver

