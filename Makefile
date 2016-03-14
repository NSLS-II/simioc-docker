image: Dockerfile
	docker build -t simioc .


run: image
	docker run -d simioc

attach: run
	docker exec -it simioc bash


clean:
	docker stop `docker ps -aq`
	docker rm   `docker ps -aq`
	docker images -q --filter "dangling=true" | xargs docker rmi
