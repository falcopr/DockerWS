#!/bin/bash
sudo mv /tmp/certs/* /etc/docker/certs.d/
sudo mv /tmp/docker/daemon.json /etc/docker/
sudo pacman -S --noconfirm docker
sudo mkdir /etc/systemd/system/docker.service.d
sudo cp -f /tmp/docker/docker.service /etc/systemd/system/docker.service.d/override.conf
sudo systemctl daemon-reload
sudo systemctl enable docker

# Setup docker client inside the virtual machine
sudo bash -c "echo -e 'export DOCKER_HOST=tcp://127.0.0.1:2376' >> /etc/profile"
sudo bash -c "echo -e 'export DOCKER_CERT_PATH=/etc/docker/certs.d' >> /etc/profile"
sudo bash -c "echo -e 'export DOCKER_TLS_VERIFY=1' >> /etc/profile"
sudo bash -c "echo -e 'export DOCKER_MACHINE_NAME=archlinux' >> /etc/profile"
# sudo systemctl start docker