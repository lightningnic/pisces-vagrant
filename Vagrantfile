# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get -y install git python-pip fuse libfuse-dev dh-autoreconf openssl libssl-dev cmake libpcap-dev python-yaml
SCRIPT

$switch_script = <<SWITCH_SCRIPT
    /vagrant/setup-switch.sh
    # Setup deskop and vncserver
    sudo apt install -y xfce4 xfce4-goodies tightvncserver
    vncserver -depth 24 -geometry 1440x900
    # Install web browser
    sudo apt install -y chromium-browser
    # Install Clion IDE
    wget https://download.jetbrains.com/cpp/CLion-2017.3.5.tar.gz -P /home/vagrant/Downloads/
    sudo tar -xvf /home/vagrant/Downloads/CLion-2017.3.5.tar.gz -C /opt/
    sudo ln -s /opt/clion-2017.3.5/bin/clion.sh /usr/bin/clion.sh
    # Install Eclipse IDE
    sudo add-apt-repository -y ppa:openjdk-r/ppa
    sudo apt-get update
    sudo apt-get -y install openjdk-8-jdk
    wget 'https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/oxygen/3/eclipse-cpp-oxygen-3-linux-gtk-x86_64.tar.gz&r=1' -O /home/vagrant/Downloads/eclipse-cpp-oxygen-3-linux-gtk-x86_64.tar.gz
    sudo tar -xvf /home/vagrant/Downloads/eclipse-cpp-oxygen-3-linux-gtk-x86_64.tar.gz -C /opt/
    sudo ln -s /opt/eclipse/eclipse /usr/bin/eclipse
    # Install gdbserver
    sudo apt-get -y install gdbserver 
SWITCH_SCRIPT

# $moongen_script = <<MOONGEN_SCRIPT
#     /vagrant/setup-moongen.sh
# MOONGEN_SCRIPT

$pktgen_script = <<PKTGEN_SCRIPT
    /vagrant/setup-pktgen.sh
PKTGEN_SCRIPT

Vagrant.configure("2") do |config|

    # Configure switch, i.e., device under test (DUT)
    config.vm.define "switch" do |switch|
        switch.vm.box = "pisces-ubuntu-trusty64"

        switch.vm.network "private_network", ip: "172.16.0.10", netmask: "255.255.255.0", virtualbox__intnet: "gen-sw"
        switch.vm.network "private_network", ip: "172.16.0.11", netmask: "255.255.255.0", virtualbox__intnet: "sw-rcv"
        # switch.vm.network "private_network", type: "dhcp"
        switch.vm.network "forwarded_port", guest: 5901, host: 5901

        switch.vm.provider "virtualbox" do |virtualbox|
            # Customize the amount of memory on the VM:
            virtualbox.memory = "4096"
            virtualbox.cpus = "4"
            # Enable promiscuous mode
            virtualbox.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
            virtualbox.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
        end

        # Setup switch
        switch.vm.provision "shell", inline: $switch_script
    end

    # Configure generator
    config.vm.define "generator" do |generator|
        generator.vm.box = "pisces-ubuntu-trusty64"

        generator.vm.network "private_network", ip: "172.16.0.12", netmask: "255.255.255.0", mac: "08002715b411", virtualbox__intnet: "gen-sw"
        generator.vm.network "private_network", ip: "172.16.0.13", netmask: "255.255.255.0", virtualbox__intnet: "gen-rcv"

        generator.vm.provider "virtualbox" do |virtualbox|
            # Customize the amount of memory on the VM:
            virtualbox.memory = "1024"
            virtualbox.cpus = "2"
            # Enable promiscuous mode
            virtualbox.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
            virtualbox.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
        end

        # Setup generator
        generator.vm.provision "shell", inline: $pktgen_script
    end

    # Configure receiver
    config.vm.define "receiver" do |receiver|
        receiver.vm.box = "pisces-ubuntu-trusty64"

        receiver.vm.network "private_network", ip: "172.16.0.14", netmask: "255.255.255.0", mac: "0800277e0b95", virtualbox__intnet: "sw-rcv"
        receiver.vm.network "private_network", ip: "172.16.0.15", netmask: "255.255.255.0", virtualbox__intnet: "gen-rcv"

        receiver.vm.provider "virtualbox" do |virtualbox|
            # Customize the amount of memory on the VM:
            virtualbox.memory = "1024"
            virtualbox.cpus = "2"
            # Enable promiscuous mode
            virtualbox.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
            virtualbox.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
        end

        # Setup receiver
        receiver.vm.provision "shell", inline: $pktgen_script
    end

    # Install essentials
    config.vm.provision "shell", inline: $script
end
