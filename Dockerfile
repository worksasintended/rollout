FROM base/archlinux
MAINTAINER Marc Marschall (marc@marschalls.net)
RUN pacman --noconfirm -Syyu &&  pacman --noconfirm -S tar git gcc wt libgl  automake autoconf vim boost  cmake make nfs-utils dhcp tftp-hpa
COPY rest_server /home/root/rest_server
ADD start_restServer.sh /usr/sbin/start_restserver.sh 
ADD initDocker.sh /initDocker.sh
COPY grub /tmp/grub
#setup Restserver
RUN cd /home/root/rest_server && cmake . && make

#setup pxe boot and dhcpserver
RUN echo "/srv       *(rw,fsid=0,no_root_squash,no_subtree_check)" >> /etc/exports && echo "/srv/install  *(rw,no_root_squash,no_subtree_check)" >> etc/exports
RUN mkdir /srv/install
VOLUME ["sys/fs/cgroup"]
EXPOSE 111/udp 2049/udp 69/udp
CMD ["/initDocker.sh"]
