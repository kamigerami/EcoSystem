# vi: set ft=ruby :

# Build a Docker Swarm / Consul / Registrator EcoSystem
# Created by Kami Gerami
#
# All node specific settings are located inside the nodes.json file
#
# read vm configurations from JSON files
nodes_config = (JSON.parse(File.read("nodes.json")))['nodes']

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|


  nodes_config.each do |node|
    node_name   = node[0] # name of node
    node_values = node[1] # content of node


    config.vm.define node_name, autostart: node_values[':auto'] do |config|    
      # configures all forwarding ports in JSON array
      ports = node_values['ports']
      ports.each do |port|
        config.vm.network :forwarded_port,
          host:  port[':host'],
          guest: port[':guest'],
          id:    port[':id']
      end

      config.vm.box = node_values[':box']
      config.vm.hostname = node_name
      config.vm.network :private_network, ip: node_values[':ip']

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", node_values[':memory']]
        vb.customize ["modifyvm", :id, "--name", node_name]
      end
    
      # Runs ansible provisioner for Consul role
      config.vm.provision "ansible" do |ansible|
          ansible.playbook = "provisioning/site.yml"
          ansible.groups = { "dockerhost" => ["dockerhost-01.example.com","dockerhost-02.example.com", "dockerhost-03.example.com"],
                             "dockerswarm" => ["dockerswarm-01.example.com"],
                             "consul" => ["consul-01.example.com", "consul-02.example.com","consul-03.example.com","consul-04.example.com"] }
     end
    if node_name !~ /^consul.*example.com$/
     # Runs Docker container provisioner for not consul-* hosts 
     config.vm.provision "docker" do |docker| 
       docker.pull_images node_values[':image']
       docker.run node_values[':image'],
         cmd: node_values[':cmd'],
         args: node_values[':args']
     end
    end

    end
  end
end
