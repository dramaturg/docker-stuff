
all:
	docker build -t dramaturg/docker-registry .

data:
	docker build -t registry-data - <Dockerfile-datastore
	docker run -d --name registry-data -t -i registry-data

run:
	docker run -d -t -i --name docker-registry --volumes-from=registry-data -p 5000:5000 dramaturg/docker-registry

