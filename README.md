[![Build Status](https://travis-ci.org/kamigerami/EcoSystem.svg?branch=master)](https://travis-ci.org/kamigerami/EcoSystem)

<img src="architecture/architecture.jpg">

# EcoSystem Nginx Load balancer branch

this will bring up a nginx LB host in addition to all of the consul and swarm nodes (master branch).
Will add a redis and a couple of frontends using python flask.

When you go to the URL of the LB the proxy_pass should put you on one of the frontends showing the python flask app saying hello-world.


Will continue configuring this (it's not complete) 

````
Versions Installed in boxes right now (will always fetch latest):

CentOS 7.1 
Docker version 1.10.3, build 20f81dd
docker-compose version 1.6.2, build 4d72027 
swarm version 1.1.3, build 7e9c6bd
gliderlabs/registrator v6
pip (8.1.1)
six (1.10.0)
setuptools (0.9.8)
docker-py (1.7.2)
consul (0.6.4)


Current machine states:

consul-01.example.com  [ Consul server + Memory, CPU, HDD checks + Docker Engine  + Registrator + Docker compose ]
consul-02.example.com  [ Consul server + Memory, CPU, HDD checks + Docker Engine + Registrator + Docker compose ]
consul-03.example.com  [ Consul server + Memory, CPU, HDD checks + Docker Engine + Registrator + Docker compose ]
Dockerswarm-01.example.com [ Docker Engine + Registrator + Swarm manager + Shipyard UI + Docker compose ]
Dockerswarm-02.example.com [ Docker Engine + Registrator + Swarm manager replication + Shipyard UI + Docker compose ]
lb-01.example.com  [ Docker Engine + Registrator + Swarm agent + Docker Compose + nginx LB ]
swarmnode-01.example.com  [ Docker Engine + Registrator + Swarm agent + Docker Compose ]
swarmnode-02.example.com  [ Docker Engine + Registrator + Swarm agent + Docker Compose ]
swarmnode-03.example.com  [ Docker Engine + Registrator + Swarm agent + Docker Compose ]
```
# Requirements

````
Ansible 2.1.x
Vagrant 1.8.x
Virtualbox v.5.x
````

# Structure
Currently this is a work in progress and I will commit, rewrite the code, commit some more, change the architechture around, use some different products like Mesos or etcd for service discovery and kubernetes instead of swarm but these will be done in different branches for example. Nothing is set in stone just yet.

I will provide more information as this ecosystem progresses further.

````
$ tree
.
├── LICENSE
├── README.md
├── Vagrantfile
├── architecture
│   └── architecture.jpg
└── provisioning
    ├── hosts
    ├── roles
    │   ├── common
    │   │   └── tasks
    │   │       ├── install.yml
    │   │       ├── main.yml
    │   │       └── pre_check.yml
    │   ├── consul
    │   │   ├── defaults
    │   │   │   └── main.yml
    │   │   ├── files
    │   │   │   ├── cpu_utilization.sh
    │   │   │   ├── hdd_utilization.sh
    │   │   │   └── mem_utilization.sh
    │   │   ├── handlers
    │   │   │   └── main.yml
    │   │   ├── tasks
    │   │   │   ├── config.yml
    │   │   │   ├── install.yml
    │   │   │   ├── main.yml
    │   │   │   └── service.yml
    │   │   └── templates
    │   │       ├── bootstrap.json
    │   │       └── consul.conf.j2
    │   ├── consultemplate
    │   │   ├── defaults
    │   │   │   └── main.yml
    │   │   ├── tasks
    │   │   │   ├── config.yml
    │   │   │   ├── install.yml
    │   │   │   └── main.yml
    │   │   └── templates
    │   │       └── consul_template.conf
    │   ├── dnsmasq
    │   │   ├── defaults
    │   │   │   └── main.yml
    │   │   ├── tasks
    │   │   │   └── main.yml
    │   │   └── templates
    │   │       └── 10-consul.conf
    │   ├── docker
    │   │   ├── defaults
    │   │   │   └── main.yml
    │   │   ├── files
    │   │   │   └── override.conf
    │   │   ├── handlers
    │   │   │   └── main.yml
    │   │   ├── tasks
    │   │   │   ├── config.yml
    │   │   │   ├── install.yml
    │   │   │   ├── main.yml
    │   │   │   └── service.yml
    │   │   ├── templates
    │   │   │   ├── docker-main.repo.j2
    │   │   │   └── sysconfig.j2
    │   │   └── vars
    │   │       └── main.yml
    │   ├── dockercompose
    │   │   └── tasks
    │   │       ├── install.yml
    │   │       └── main.yml
    │   ├── dockerswarm
    │   │   └── tasks
    │   │       ├── agent.yml
    │   │       ├── main.yml
    │   │       ├── manager.yml
    │   │       └── replica.yml
    │   ├── final
    │   │   └── tasks
    │   │       └── main.yml
    │   ├── nginx
    │   │   ├── files
    │   │   │   └── consul_template.ctmpl
    │   │   └── tasks
    │   │       ├── config.yml
    │   │       ├── lb.yml
    │   │       └── main.yml
    │   ├── registrator
    │   │   └── tasks
    │   │       └── main.yml
    │   └── shipyard
    │       └── tasks
    │           ├── controller.yml
    │           ├── datastore.yml
    │           └── main.yml
    ├── scripts
    │   ├── Dockerfile
    │   ├── README.md
    │   ├── app.py
    │   ├── docker-compose.yml
    │   └── requirements.txt
    └── site.yml

40 directories, 58 files
````
# ToDo

Add redis, front--ends and a working LB with dynamic updated configuration using consul-template or nginx-proxy or confd or something similar.


# How to 

```
vagrant up 
```
Go to :  http://192.168.35.101 to access your Consul UI.

Go to :  http://192.168.35.124:8080 to access your ShipYard UI (username/pw = admin/shipyard)

