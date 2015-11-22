hostname: consul-01.example.com
ip: 192.168.35.121
consul_extra: -server -bootstrap-expect 2 -ui-dir /opt/consul/ui/dist -config-dir /etc/consul.d/server/config.json
swarm_master: true
