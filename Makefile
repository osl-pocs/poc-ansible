
DOCKER_GET_IP:=docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
DOCKER_GET_HOST_ID:=docker ps -aqf "name=poc-ansible-host"

DOCKER_SERVICES:=docker-compose -f services/docker-compose.yaml
DOCKER_HOST:=docker-compose -f host/docker-compose.yaml

docker-dind:
	docker run \
		--name dind-poc-ansible -d \
		--privileged \
    	--network host \
		--rm \
    	docker:dind

docker-host-build:
	$(DOCKER_HOST) build

docker-host-start:
	$(MAKE) docker-dind
	$(DOCKER_HOST) up -d

docker-host-stop:
	$(DOCKER_HOST) stop

docker-host-bash:
	$(DOCKER_HOST) exec poc-ansible-host bash

docker-service-build:
	$(DOCKER_SERVICES) build

docker-service-start:
	$(DOCKER_SERVICES) up -d

docker-service-stop:
	$(DOCKER_SERVICES) stop

docker-get-host-ip:
	@$(DOCKER_GET_IP) `$(DOCKER_GET_HOST_ID)`

update-inventory:
	@export CONTAINER_ID=`$(DOCKER_GET_HOST_ID)` \
	&& echo `$(DOCKER_GET_IP) $$CONTAINER_ID` "ansible_port=2222" > inventory

ansible-ping:
	@ansible all -m ping

test-ansible:
	ansible-playbook tests/playbooks/simple.yml

deploy:
	ansible-playbook --verbose playbooks/main.yaml
