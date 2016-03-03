#!/usr/bin/env bash

prepare_sudo () {
    echo "Will now call:  sudo"
    echo "Please supply a password to sudo (if it is no longer cached)"
    sudo echo -n "temporarily working as " && sudo whoami    || exit 1               ## fail is sudo did not work
}

prepare_sudo

sudo apt-get install docker.io
sudo docker pull greyltc/archlinux

mkdir data_volume

sudo docker build -t="my_archlinux" .
sudo docker run --name arch1 -v $(readlink -e data_volume):/data_volume              -it my_archlinux sudo -u user1 /bin/bash -l
#sudo docker rm arch1
