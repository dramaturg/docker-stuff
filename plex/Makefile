
all: 
	docker build -t dramaturg/plex .

run:
	docker run -d -i -t --name=plex -p 32400:32400 -p 32443:32443 dramaturg/plex
	# firefox http://localhost:32400/manage/index.html

push:
	docker tag dramaturg/plex dramaturg/plex:$$(date +%Y%m%d) 
	docker push dramaturg/plex

