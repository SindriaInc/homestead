#!/bin/bash

## Fix Ubuntu 16.04 - VirtualBox & Vagrant
echo "Start Ubuntufixer..."
sudo apt update && sudo apt upgrade -y
echo "Do you want install virtualbox-5.1.34?(Please type yes)"
read confirmation
if [ $confirmation != "yes" ]; then
  #echo "Installing latest version of virtualbox..."
  #wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  #wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
  #sudo echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" >> /etc/apt/sources.list
  #sudo apt update && sudo apt install virtualbox-5.2 -y
  echo "Aborted"
  exit
fi;

echo "Install virtualbox-5.1.34..."
sudo apt-get install software-properties-common -y && \
sudo add-apt-repository ppa:tmate.io/archive -y && \
sudo apt-get update && \
sudo apt-get install tmate -y
sudo apt install virtualbox-5.1 -y

echo "Do you want config develop workstation?(Please type yes)"
read confirmation
if [ $confirmation != "yes" ]; then
  echo "Aborted"
  exit
fi;

echo "Installing package..."
sudo apt install git wget composer vim -y
cd /tmp
wget https://releases.hashicorp.com/vagrant/1.9.2/vagrant_1.9.2_x86_64.deb
sudo apt install ./vagrant_1.9.2_x86_64.deb -y

echo "Adding laravel/homestead box..."
vagrant box add laravel/homestead

echo "Insert local username for this pc:"
read username
echo insert: $username
echo "Insert your domain name:"
read domain
echo insert: $domain
echo "Insert projects folder name:"
read folder
echo insert: $folder

echo "Making local config..."
mkdir /home/$username/$folder/
mkdir /home/$username/.ssh/
mkdir /home/$username/.ssh/homestead/
echo "Do you want create the ssh-key?(Please type yes)"
read confirmation
if [ $confirmation != "yes" ]; then
  echo "Aborted"
  exit
fi;

echo "Remember enter the id_rsa name: vagrant@my-domain-name "
echo "With no passphrase. (enter twice)"
echo "Wait 30 seconds..."
sleep 30
cd /home/$username/.ssh/homestead/
ssh-keygen

echo "Fix key permission..."
chmod 700 /home/$username/.ssh/
chmod 600 /home/$username/.ssh/*
chmod 600 /home/$username/.ssh/homestead/*

cd /home/$username/$folder/
git clone https://github.com/SindriaInc/sindria-homestead-magento1.9.git
mv sindria-homestead-magento1.9 $domain
cd /home/$username/$folder/$domain
echo "Edit Homestead.yaml file with your parameters"
echo "Wait 15 seconds..."
sleep 15
vim Homestead.yaml

# Optional set custom directory machine for virtualbox
#mkdir /home/$username/vagrantbox.local
#vboxmanage setproperty machinefolder /home/$username/projects-triboo/

echo "Do you want enable .local extension?(Please type yes)"
read confirmation
if [ $confirmation == "yes" ]; then
 echo "Enabling .local extension and restart network..."
 sudo sed -i '12s/.*/hosts:          files dns [NOTFOUND=return] dns mdns4_minimal/' /etc/nsswitch.conf
 sudo service network-manager restart
fi;

echo "Setting up vagrant..."
cd /home/$username/$folder/$domain/
pwd
#vagrant init
vagrant plugin install vagrant-hostmanager
vagrant up --provider="virtualbox"

echo "File hosts update automatically: vagrant-hostmanager "
echo "Vagrant box setup complete, to connect it use: vagrant ssh "
echo "Done."

