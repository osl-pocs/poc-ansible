
DOCKER_GET_IP:=docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
DOCKER_GET_HOST_ID:=docker ps -aqf "name=poc-ansible-host"

DOCKER_SERVICES:=docker-compose -f services/docker-compose.yaml
DOCKER_HOST:=docker-compose -f host/docker-compose.yaml

build-host:
	$(DOCKER_HOST) build

start-host:
	$(DOCKER_HOST) up -d

build-service:
	$(DOCKER_SERVICES) build

start-service:
	$(DOCKER_SERVICES) up -d


docker-get-host-ip:
	@$(DOCKER_GET_IP) `$(DOCKER_GET_HOST_ID)`

update-inventory:
	@export CONTAINER_ID=`$(DOCKER_GET_HOST_ID)` \
	&& echo `$(DOCKER_GET_IP) $$CONTAINER_ID` "ansible_port=2222" > inventory

ansible-ping:
	@ansible all -m ping

test-ansible:
	ansible-playbook -i inventory tests/playbooks/simple.yml
