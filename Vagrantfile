# vi: set ft=ruby :

# Build a Docker Swarm / Consul / Registrator EcoSystem
# Created by Kami Gerami
#

# Vars
domainname = "example.com"
cluster_name = "dockerswarm"
engine_name = "dockerhost"
discovery_name = "consul"
hostname_vars = Hash.new { |hash, key| hash[key] = [] } # hash for extra vars

nodes = [
  { :hostname => "#{discovery_name}-01.#{domainname}", :ip => "192.168.35.101" },
  { :hostname => "#{discovery_name}-02.#{domainname}", :ip => "192.168.35.102" },
  { :hostname => "#{discovery_name}-03.#{domainname}", :ip => "192.168.35.103" },
  { :hostname => "#{engine_name}-01.#{domainname}", :ip => "192.168.35.121" },
  { :hostname => "#{engine_name}-02.#{domainname}", :ip => "192.168.35.122" },
  { :hostname => "#{engine_name}-03.#{domainname}", :ip => "192.168.35.123" },
  { :hostname => "#{cluster_name}-01.#{domainname}", :ip => "192.168.35.124" },

]

groups = { 
    "#{engine_name}" => [], 
    "#{cluster_name}" => [],
    "#{discovery_name}" => [],
    "all:children" => ["#{engine_name}","#{cluster_name}","#{discovery_name}"], 
    }


Vagrant.configure(2) do |config|

  nodes.each do |node|
 
  # set the host specific vars
  hostname = node[:hostname]
  ip = node[:ip]
  memory = node[:memory] || "512" # set 512 as default if nothing else is set
  run = node[:run] || "always" # set provisioner to run always if nothing else is set
  autostart = node[:autostart] || "true" # set to always autostart machines unless set
  box = node[:box] || "centos/7" # set to run centos/7 as default unless set
  provisioner = node[:provisioner] || "ansible" # sets ansible as default provisioner
  docker_cmd = node[:docker_cmd]
  docker_args = node[:docker_args]

  # create ansible.extra_vars with IP and name of each host
  hostname_vars[:ip] << node
  hostname_vars[:hostname] << node
 
  # create the ansible groups
  case hostname
  when /#{Regexp.escape(engine_name)}/
    groups["#{engine_name}"].push(hostname)
  when /#{Regexp.escape(cluster_name)}/
    groups["#{cluster_name}"].push(hostname)
  when /#{Regexp.escape(discovery_name)}/
    groups["#{discovery_name}"].push(hostname)
  end

    config.vm.define hostname, autostart: autostart do |config|    

      config.vm.box = box
      config.vm.hostname = hostname
      config.vm.network :private_network, ip: ip

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", memory, "--name", hostname]
      end
    
      # Runs a provisioner 
      config.vm.provision provisioner, run: run do |pv|
        case provisioner
        when "ansible" 
            pv.playbook = "provisioning/site.yml"
            pv.groups = groups
            pv.sudo = true
            pv.extra_vars = hostname_vars
        when "docker"
            pv.pull_images image
            pv.run image,
            cmd: docker_cmd,
            args: docker_args 
        end
      end
    end
  end
end
