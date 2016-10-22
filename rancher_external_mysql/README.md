# Rancher + External MYSQL db
A Rancher single host server connecting to a MYSQL database both running in separate containers
and mounting the mysql volume on the host.

Will continue to add stuff continuously

````
Rancher-Server 1.2.0-pre3
Mysql-Server 14.14 Distrib 5.7.16

```
# Requirements

```
docker
docker-compose
```

# Optional Vagrant Kubernetes setup

Vagrantfile will setup 3 hosts on centos/7.

Ansible roles will install and start:

- docker version 1.12.2
- docker-compose version 1.8.1
- etcd version 3.0.12

Todo: Kubernetes cluster setup

# Structure

Container 1: rancher-server -> Container 2
Container 2: mysql-server

Currently this is a work in progress and I will commit, rewrite the code, commit some more, change the architechture around, 

I will provide more information as this ecosystem progresses further.

```
$ tree
.
├── README.md
└── docker-compose.yml

0 directories, 2 files
```

# How to 

```
# Set password / port / username and db name in .env file
$ cat .env
# MYSQL ENV VARIABLES
MYSQL_DATABASE=mysql_rancher_db
MYSQL_USER=mysql_rancher_user
MYSQL_PASSWORD=mysql_pw
MYSQL_PORT=3306

docker-compose up -d
(this will create a mysql directory for the mysql database on your host-machine)
```
Go to :  http://localhost:8080 to access Rancher-UI

