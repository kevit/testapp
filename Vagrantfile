# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
config.vm.synced_folder ".", "/vagrant", disabled: true
config.vm.network :private_network, ip: "192.168.77.77"

config.vm.define :demo do |demo|
  demo.vm.hostname = "vagrant.kevit.info"
  demo.vm.box = "ubuntu/bionic64"
  demo.vm.provider :virtualbox do |v|
    v.name = "vagrant.kevit.info"
  end

  demo.vm.provision "ansible" do |ansible|
  ansible.playbook = "deploy.yml"
  ansible.galaxy_roles_path = "roles"
  ansible.inventory_path = "inventories/vagrant/hosts.ini" 
#  ansible.verbose = "vvv"
  ansible.become = true
  end

end
end
