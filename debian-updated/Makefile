
all: stable testing

stable:
	docker pull debian:wheezy
	docker build --no-cache=true -t dramaturg/debian-updated .

testing:
	docker pull debian:testing
	docker build --no-cache=true -t dramaturg/debian-updated:testing - < Dockerfile-testing

push:
	docker push dramaturg/debian-updated
