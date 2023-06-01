#!/usr/bin/env bash

sudo apt upgrade -y
sudo apt install -y docker.io

sudo docker info > info

sudo sed -i \
'$ s/$/ cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 swapaccount=1/' \
/boot/firmware/cmdline.txt

sudo reboot
