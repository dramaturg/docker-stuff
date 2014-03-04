
all:
	docker build -t dramaturg/etcd .

run:
	docker run -d -i -t -h etcd-test --name=etcd-test -p 4001:4001 -p 7001:7001 dramaturg/etcd

