
all: 
	docker build -t dramaturg/debian-plex .

run:
	docker run -d -i -t --name=plex -p 32400:32400 -p 32443:32443 dramaturg/debian-plex
	# firefox http://localhost:32400/manage/index.html

