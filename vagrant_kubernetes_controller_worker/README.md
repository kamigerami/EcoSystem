# Vagrant - Kubernetes controller, etcd, kube-apiserver, kube-scheduler setup + worker

Vagrantfile will setup 3 hosts on centos/7.

Ansible roles will install and start:

- docker version 1.12.2
- docker-compose version 1.8.1
- etcd version 3.0.12
- kubernetes 1.4.4

It will download kubernetes.tar.gz locally first (to /var/tmp/)
then copy it over to the remote vagrant hosts.

# Structure

```
controller-01.example.com - kube-controller-manager, kube-apiserver, kube-scheduler, etcd
worker-01.example.com - kubectl
worker-02.example.com - kubectl
```
# Requirements

```
ansible
vagrant
```
Currently this is a work in progress and I will commit, rewrite the code, commit some more, change the architechture around, 

I will provide more information as this ecosystem progresses further.

```
$ tree
.
├── README.md
├── Vagrantfile
├── ansible.cfg
└── provisioning
    ├── hosts
    ├── roles
    │   ├── common
    │   │   └── tasks
    │   │       └── main.yml
    │   ├── docker
    │   │   ├── defaults
    │   │   │   └── main.yml
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
    │   ├── etcd
    │   │   ├── defaults
    │   │   │   └── main.yml
    │   │   ├── files
    │   │   │   └── etcd.service
    │   │   ├── handlers
    │   │   │   └── main.yml
    │   │   └── tasks
    │   │       ├── config.yml
    │   │       ├── install.yml
    │   │       └── main.yml
    │   ├── kubernetes
    │   │   ├── defaults
    │   │   │   └── main.yml
    │   │   └── tasks
    │   │       ├── install.yml
    │   │       └── main.yml
    │   ├── kubernetes-controller
    │   │   ├── defaults
    │   │   │   └── main.yml
    │   │   ├── files
    │   │   │   ├── kube-apiserver.service
    │   │   │   ├── kube-controller-manager.service
    │   │   │   └── kube-scheduler.service
    │   │   ├── handlers
    │   │   │   └── main.yml
    │   │   └── tasks
    │   │       ├── config.yml
    │   │       └── main.yml
    │   └── kubernetes-worker
    │       ├── files
    │       │   └── kubelet.service
    │       ├── handlers
    │       │   └── main.yml
    │       └── tasks
    │           ├── config.yml
    │           └── main.yml
    └── site.yml

29 directories, 37 files
```

# How to 

```
vagrant up
```
