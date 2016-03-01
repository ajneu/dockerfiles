#!/usr/bin/env bash

prepare_sudo () {
    echo "Will now call:  sudo"
    echo "Please supply a password to sudo (if it is no longer cached)"
    sudo echo -n "temporarily working as " && sudo whoami    || exit 1               ## fail is sudo did not work
}




mkdir -p ~/docker_dir
cd       ~/docker_dir

prepare_sudo
sudo apt-get install docker.io
sudo docker pull greyltc/archlinux

mkdir -p archlinux
cd       archlinux

cat <<EOF    > Dockerfile
FROM    greyltc/archlinux

## use the following mirror in /etc/pacman.d/mirrorlist
## ==>  http://mirror.rackspace.com/archlinux/$repo/os/$arch
RUN     mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.prev
RUN     echo "Server = http://mirror.rackspace.com/archlinux/\\\$repo/os/\\\$arch" >  /etc/pacman.d/mirrorlist
RUN     cat /etc/pacman.d/mirrorlist.pacnew                                    >> /etc/pacman.d/mirrorlist


## update
RUN     pacman -Syu

## download base-devel
RUN     pacman --noconfirm --needed -S base-devel


## download sudo package
RUN     pacman --noconfirm --needed -S sudo

## add sudo group
RUN     groupadd sudo

## members of sudo group can issue sudo without password
RUN     echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

## create user1 with membership in group sudo (-G) and a home-directory (-m) and using shell bash (-s)
RUN     useradd -G sudo -ms /bin/bash user1

ENV     HOME /home/user1
#RUN     chown -R user1:user1 \$HOME

USER    user1

WORKDIR \$HOME

EOF

sudo docker build -t="my/archlinux" .
sudo docker run --name arch1 --user user1 -it my/archlinux /bin/bash -l
#sudo docker rm arch1
