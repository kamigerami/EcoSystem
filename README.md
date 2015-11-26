<img src="http://demo.consul.io/ui/static/consul-logo.png" width="48">
<img src="http://www.thekelleys.org.uk/dnsmasq/images/icon.png" width="48">
<img src="https://github.com/docker/docker/blob/master/docs/static_files/docker-logo-compressed.png" width=96">
<img src="https://www.mongodb.com/assets/MongoDB_Brand_Resources/MongoDB-Logo-5c3a7405a85675366beb3a5ec4c032348c390b3f142f5e6dddf1d78e2df5cb5c.png" width="96">
<img src="https://www.nginx.com/wp-content/themes/nginx-theme/assets/img//logo.png" width="96">

# EcoSystem
A Consul, Dnsmasq, Docker Swarm, DB and webservices ecosystem simulating a real world production setup




# Structure


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
    ├── host_vars
    │   ├── consul-01.example.com
    │   ├── consul-02.example.com
    │   ├── consul-03.example.com
    │   └── consul-04.example.com
    ├── hosts
    ├── roles
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
    │   └── dnsmasq
    │       ├── defaults
    │       │   └── main.yml
    │       ├── tasks
    │       │   └── main.yml
    │       └── templates
    │           └── 10-consul.conf
    └── site.yml
    

