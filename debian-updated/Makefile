
all:
	docker build -t dramaturg/debian-updated .

rebuild:
	docker pull debian:jessie
	docker build --no-cache=true -t dramaturg/debian-updated .

push:
	docker tag dramaturg/debian-updated dramaturg/debian-updated:$$(date +%Y%m%d) 
	docker push dramaturg/debian-updated

run:
	docker run -d -i -t dramaturg/debian-updated
