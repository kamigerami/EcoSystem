# vi: set ft=ruby :

# Build a Docker Swarm / Consul / Registrator EcoSystem
# Created by Kami Gerami
#

# Vars
domainname = "example.com"
cluster_name = "dockerswarm"
engine_name = "dockerhost"
discovery_name = "consul"

nodes = [
  { :hostname => "#{discovery_name}-01.#{domainname}", :ip => "192.168.35.101" },
  { :hostname => "#{discovery_name}-02.#{domainname}", :ip => "192.168.35.102" },
  { :hostname => "#{discovery_name}-03.#{domainname}", :ip => "192.168.35.103" },
  { :hostname => "#{engine_name}-01.#{domainname}", :ip => "192.168.35.121" },
  { :hostname => "#{engine_name}-02.#{domainname}", :ip => "192.168.35.122" },
  { :hostname => "#{engine_name}-03.#{domainname}", :ip => "192.168.35.123" },
  { :hostname => "#{cluster_name}-01.#{domainname}", :ip => "192.168.35.124", :provisioner => "docker", :image => "swarm", :cmd => "create", :args => ""},

]

groups = { 
    "#{engine_name}" => [], 
    "#{cluster_name}" => [],
    "#{discovery_name}" => [],
    "#{discovery_name}_master" => ["#{discovery_name}-01.#{domainname}"],
    "#{discovery_name}_server" => ["#{discovery_name}-02.#{domainname}", "#{discovery_name}-03.#{domainname}"],
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
  docker_cmd = node[:cmd] # docker command
  docker_args = node[:args] # docker arguments
  image = node[:image] # docker image 

  # create ansible.extra_vars 
  ansible_vars =  {
    :common => {
      :master_ip => "192.168.35.101",
      :server_ip_1 => "192.168.35.102",
      :server_ip_2 => "192.168.35.103",
    },
     :master => {
      :bootstrap_flag => "true",
      :server_flag => "true",
      :ui_flag => "true",
      :host_type => "bootstrap",
    },
    :server => {
      :bootstrap_flag => "false",
      :server_flag => "true",
      :ui_flag => "false",
      :host_type => "server",
    },
    :agent => {
      :bootstrap_flag => "false",
      :server_flag => "false",
      :ui_flag => "false",
      :host_type => "agent",
    },
    :swarm => {
      :master_name => "#{cluster_name}-01.#{domainname}",
      :master_ip => "192.168.35.124"
    }
  }
 
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

      # always run ansible provisioner
      config.vm.provision "ansible", run: run do |pv|
            pv.playbook = "provisioning/site.yml"
            pv.groups = groups
            pv.sudo = true
            pv.extra_vars = ansible_vars
            pv.verbose = 'vvvv'
      end

      # #8 - Update to support ansible 2.x
      # this provisioner is not being used any more
      # in favor for running the docker modules
      # that will manage containers inside the tasks instead
      # as a playbook.
      #
      # Runs a provisioner 
#      if provisioner == "docker"
#           config.vm.provision "docker", run: run do |pv|
#             pv.pull_images image
#             pv.run image,
#            cmd: docker_cmd,
#             args: docker_args 
#           end
#     end
    end
  end
end
