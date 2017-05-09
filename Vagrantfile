# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |c|

  c.vm.define 'immerse-demo' do |v|
    v.vm.hostname = 'immerse-demo'
    v.vm.box = 'bstopp/centos-7.2-x64'
    v.vm.box_check_update = 'true'
    v.vm.network :private_network, ip: "10.255.200.101", :netmask => "255.255.0.0", :mac => "080027966EA7"
    v.vm.provider :virtualbox do |vb|
      vb.name = 'immerse-demo'
      vb.memory = '8192'
      vb.cpus = '2'
    end

    v.vm.provision :shell, path: 'setup/update-vm.sh'
    v.vm.provision :shell, path: 'setup/puppet.sh'

    v.vm.provision :puppet do |puppet|
      puppet.module_path = 'puppet/modules'
      puppet.environment_path = 'puppet/environments'
      puppet.environment = 'local'
    end

    v.vm.network :forwarded_port, guest:80, host:10080
    v.vm.network :forwarded_port, guest:8080, host:18080
    v.vm.network :forwarded_port, guest:8009, host:18009
    v.vm.network :forwarded_port, guest:4502, host:4502
    v.vm.network :forwarded_port, guest:4503, host:4503
    v.vm.network :forwarded_port, guest:30300, host:30300
    v.vm.network :forwarded_port, guest:30303, host:30303
    v.vm.network :forwarded_port, guest:30304, host:30304
  end
end
