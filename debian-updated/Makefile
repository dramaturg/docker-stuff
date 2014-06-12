
all:
	docker build -t dramaturg/debian-updated .

rebuild:
	docker pull debian:wheezy
	docker build --no-cache=true -t dramaturg/debian-updated .

push:
	docker push dramaturg/debian-updated

run:
	docker run -d -i -t dramaturg/debian-updated
