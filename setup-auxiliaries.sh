#!/usr/bin/env bash

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
sudo apt-get -y install gdb gdbserver
