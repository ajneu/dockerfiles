FROM    greyltc/archlinux

## uncomment the following if you're behind a proxy
#  ENV     http_proxy  "http://ip_of_proxy:port"
#  ENV     https_proxy "http://ip_of_proxy:port"


## use the following mirror in /etc/pacman.d/mirrorlist
## ==>  http://mirror.rackspace.com/archlinux/$repo/os/$arch
RUN     mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.prev
RUN     echo "Server = http://mirror.rackspace.com/archlinux/\$repo/os/\$arch" >  /etc/pacman.d/mirrorlist
RUN     cat /etc/pacman.d/mirrorlist.pacnew                                    >> /etc/pacman.d/mirrorlist



## uncomment the following if you're behind a proxy (setup pacman to use wget -> longer timeout periods)
#  ## install wget
#  RUN     pacman --noconfirm -S wget
#  ## setup pacman to use wget (it has longer timeout periods, by default 900 seconds)
#  RUN     sed -i "s|^#XferCommand = .*wget.*$|XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u|" /etc/pacman.conf


## update
RUN     pacman -Syu

## download base-devel
RUN     pacman --noconfirm --needed -S base-devel

## download git package
RUN     pacman --noconfirm --needed -S git

## download cmake
RUN     pacman --noconfirm --needed -S cmake extra-cmake-modules

## download sudo package
RUN     pacman --noconfirm --needed -S sudo

## add sudo group
RUN     groupadd sudo

## members of sudo group can issue sudo without password
RUN     echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

## create user1 with membership in group sudo (-G) and a home-directory (-m) and using shell bash (-s)
RUN     useradd -G sudo -ms /bin/bash user1

ENV     HOME /home/user1
#RUN     chown -R user1:user1 $HOME

RUN     mkdir            /data_volume
RUN     chown root:user1 /data_volume
#VOLUME  /data_volume

USER    user1

WORKDIR $HOME
