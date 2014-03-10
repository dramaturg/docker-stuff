
host        = etcd.darksystem.net
ssl_MyOrg   = Darksystem Projects
ssl_MyCity  = Amsterdam
ssl_MyState = Noord-Holland
ssl_MyCC    = NL


all: 
	docker build -t dramaturg/etcd .

run:
	docker run -d -i -t -h etcd-test --name=etcd-test -p 4001:4001 -p 7001:7001 dramaturg/etcd

ssl: ssl-management new

ssl-management: ssl-management.make ssl-management.sed
include ssl-management.make

ssl-management.sed:
	sed -i \
		-e "s/<<MyOrg>>/$(ssl_MyOrg)/g" \
		-e "s/<<MyCity>>/$(ssl_MyCity)/g" \
		-e "s/<<MyState>>/$(ssl_MyState)/g" \
		-e "s/<<MyCC>>/$(ssl_MyCC)/g" \
		ssl-management.make

ssl-management.make:
	curl -LO https://raw.github.com/dramaturg/geskripte/master/ssl-management.make

