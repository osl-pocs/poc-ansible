# poc-ansible

## Environment

Install the conda environment with ansible command:

```sh
$ mamba env create --file environment.yaml
```

Note: In this examples, it uses mamba for creating the environment,
but you can use conda instead if you want.

After that, you can activate the environment with the following command:

```sh
$ conda activate poc-ansible
```

Note: for the environment activate you should use conda (not mamba).

## Start the machine that will act as host:

First, change to the `host` directory:

```sh
$ cd host
```

Build the image for the host machine and start the container:

```sh
$ docker-compose build
$ docker-compose up -d
```

After that identify the container id using the following command:

```sh
$ docker ps

# output
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                      NAMES
8c2c0d54e92b        my-host             "tini -- /bin/sh -c …"   4 hours ago         Up About a minute   0.0.0.0:9999->9999/tcp                     pocansible_my-host_1
```

In my case, my container id is `8c2c0d54e92b`.

Now, run a command to get the network IP for this container id:

```sh
$ docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 8c2c0d54e92b
# output
172.19.0.2
```

The network IP address for our host container is `172.19.0.2`. Now, change the file 
`inventory` with the IP address for your own container.


To check if your container is reachable from ansible, run: 

```sh
$ cd ..  # go first to the root of the project again
$ ansible all -m ping
```

You can test it using the `ssh` command directly:

```sh
$ ssh 172.19.0.2 -p 2222
```

Also, if you need to connect directly to the container, run:

```sh
$ docker-compose exec poc-ansible-host bash
```

## Deployment

For running the ansible command, type:

```sh
$ ansible-playbook playbooks/main.yaml
```
