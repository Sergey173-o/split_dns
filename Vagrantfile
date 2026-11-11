# -*- mode: ruby -*-
# Поднимает четыре ВМ для лаборатории Split-DNS.

Vagrant.configure("2") do |config|
  config.vm.box = "almalinux/9"
  config.vm.box_url = "https://vagrant.almalinux.org/almalinux/9"
  config.vm.boot_timeout = 900
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 1
  end

  hosts = {
    "ns01"    => "192.168.50.10",
    "ns02"    => "192.168.50.11",
    "client"  => "192.168.50.15",
    "client2" => "192.168.50.16"
  }

  hosts.each do |name, ip|
    config.vm.define name do |node|
      node.vm.hostname = name
      node.vm.network "private_network", ip: ip, virtualbox__intnet: "dns"
    end
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
    ansible.groups = {
      "dns_servers" => ["ns01", "ns02"],
      "dns_clients" => ["client", "client2"]
    }
    ansible.extra_vars = { "lab_addresses" => hosts }
  end
end
