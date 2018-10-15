#!/usr/bin/env bash

# check ubuntu
SYSTEM_VERSION_STR=$(cat /etc/issue)
if [$SYSTEM_VERSION_STR == ""]; then
  echo "this script supports ubuntu 14/16 only"
  exit
fi

# check if docker is installed
if [ $(which docker | wc -l | grep -c 1) == 1 ]; then
  echo "docker is installed"
  exit
else
  echo "installing docker......"
fi

# add docker repo
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
# add bash
sudo bash -c "echo deb https://get.docker.io/ubuntu docker main >/etc/apt/sources.list.d/docker.list"
# begin install docker
sudo apt-get update
sudo apt-get install lxc-docker -y
# show version
sudo docker -v
# show docker port
ps -ef | grep docker

echo "check docker install result......"
if [ $(which docker | wc -l | grep -c 1) == 1 ]; then
  echo "docker install success"
else
  echo "docker install fail"
fi
