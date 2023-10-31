# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.define "linux" do |linux|
      linux.vm.box = "cybersecurity/linux-scavenger"
      linux.ssh.insert_key = false
      linux.vm.network "private_network", ip: "192.168.200.105"
      linux.vm.synced_folder ".", "/vagrant", disabled: true
      config.vm.ignore_box_vagrantfile = true

      linux.vm.provider "vbox" do |vb| # specify hyper v vm
        vb.memory = 1024
        vb.cpus = 1
      end
    end
  end