
all:
	docker pull debian:wheezy
	docker build --rm=true -t dramaturg/debian-updated .

push:
	docker push dramaturg/debian-updated
