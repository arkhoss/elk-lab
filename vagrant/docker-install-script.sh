#!/bin/bash

cat /vagrant/control.pub >> /home/vagrant/.ssh/authorized_keys

# tools
sudo yum install -y yum-utils device-mapper-persistent-data lvm2  net-tools nano

# install docker steps
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io

sudo systemctl start docker

sudo groupadd docker

sudo usermod -aG docker $USER

sudo systemctl enable docker

sudo docker run --rm hello-world

# install docker-compose steps
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
