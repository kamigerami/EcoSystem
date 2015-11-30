<a href="http://consul.io"><img src="http://demo.consul.io/ui/static/consul-logo.png" width="48"></a>
<a href="http://www.thekelleys.org.uk/dnsmasq/doc.html"><img src="http://www.thekelleys.org.uk/dnsmasq/images/icon.png" width="48"></a>
<a href="https://www.docker.com"><img src="https://github.com/docker/docker/blob/master/docs/static_files/docker-logo-compressed.png" width=96"></a>
<a href="https://www.mongodb.com"><img src="https://www.mongodb.com/assets/MongoDB_Brand_Resources/MongoDB-Logo-5c3a7405a85675366beb3a5ec4c032348c390b3f142f5e6dddf1d78e2df5cb5c.png" width="96"></a>
<a href="https://nginx.com"><img src="https://www.nginx.com/wp-content/themes/nginx-theme/assets/img//logo.png" width="96"></a>

# EcoSystem
A Consul, Dnsmasq, Docker Swarm, DB and webservices ecosystem simulating a real world production setup

This will bring up the following hosts all running Centos/7 with Consul Agents, Docker-Engine.


````
Current machine states:

dockerhost-01.example.com  [ Consul Agent + Memory, CPU, HDD checks + Docker Engine ]
dockerhost-02.example.com  [ Consul Agent + Memory, CPU, HDD checks + Docker Engine ]
dockerhost-03.example.com  [ Consul Agent + Memory, CPU, HDD checks + Docker Engine ]
dockerswarm-01.example.com [ Consul Agent + Memory, CPU, HDD checks + Docker Engine + DockerSwarm ]
consul-01.example.com  [ Consul server + Memory, CPU, HDD checks + Docker Engine ]
consul-02.example.com  [ Consul server + Memory, CPU, HDD checks + Docker Engine ]
consul-03.example.com  [ Consul server + Memory, CPU, HDD checks + Docker Engine ]
consul-04.example.com  [ Consul Agent + Memory, CPU, HDD checks + Docker Engine ]

```


# Structure
Currently this is a work in progress and I will commit, rewrite the code, commit some more, change the architechture around, use some different products like Mesos for example. Nothing is set in stone just yet.

I will provide more information as this ecosystem progresses further.

````
$ tree
.
├── LICENSE
├── README.md
├── Vagrantfile
├── nodes.json
└── provisioning
    ├── consul.yml
    ├── dnsmasq.yml
    ├── docker.yml
    ├── host_vars
    │   ├── consul-01.example.com
    │   ├── consul-02.example.com
    │   ├── consul-03.example.com
    │   ├── consul-04.example.com
    │   ├── dockerhost-01.example.com
    │   ├── dockerhost-02.example.com
    │   └── dockerhost-03.example.com
    ├── hosts
    ├── roles
    │   ├── common
    │   │   └── tasks
    │   │       └── main.yml
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
    │   │   │   └── main.yml
    │   │   └── templates
    │   │       ├── bootstrap.json
    │   │       └── consul.conf.j2
    │   ├── dnsmasq
    │   │   ├── defaults
    │   │   │   └── main.yml
    │   │   ├── tasks
    │   │   │   └── main.yml
    │   │   └── templates
    │   │       └── 10-consul.conf
    │   └── docker
    │       ├── defaults
    │       │   └── main.yml
    │       ├── files
    │       │   └── override.conf
    │       ├── handlers
    │       │   └── main.yml
    │       ├── tasks
    │       │   └── main.yml
    │       ├── templates
    │       │   ├── docker-main.repo.j2
    │       │   └── sysconfig.j2
    │       └── vars
    │           └── main.yml
    └── site.yml

````
# ToDo

Add Loadbalancing, Scheduler, orchestration, WebApps, DB's etc ...


# How to 

```
vagrant up /consul/
vagrant up /docker/
```
Go to :  http://192.168.35.121 to access your Consul UI.



