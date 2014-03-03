
all:
	docker build -t dramaturg/centos-mysql .

data:
	docker build -t mysql-data-foreman - <Dockerfile-datastore
	docker run -d --name mysql-data-foreman -t -i mysql-data-foreman

run:
	docker run -d -t -i --name mysql-foreman --volumes-from=mysql-data-foreman dramaturg/centos-mysql

