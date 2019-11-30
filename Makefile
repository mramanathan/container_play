stage=test
container_name=nginx-webserver-$(stage)

.DEFAULT_GOAL := start_container

IMG = $(shell docker image ls --format='{{json .Repository}}' | grep -i nginx_$(stage))
#PORT = $(shell docker container ls --filter "NAME=$(container_name)" --format='{{json .Ports}}' | cut -d":" -f2 | cut -c{1..5})
#PORT = $(shell docker container ls --format='{{ .Ports}}')

start_container: nginx
	@echo "[STAGE ::: $(stage)]: ========= Starting a fresh NGINX container for $(stage)..."
	docker run --rm -d -it --name $(container_name) -P nginx_$(stage)

nginx:
	@echo "[STAGE ::: $(stage)]: ========= Building NGINX image for $(stage)..."
	cd $(stage) && docker build --rm -t nginx_$(stage) -f Dockerfile.nginx .
	@echo "[STAGE ::: $(stage)]: ========= Docker image, $(IMG) was built!!!"

