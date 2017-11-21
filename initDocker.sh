#!/bin/bash
echo "unpacking image"
tar  -C /srv/install -xf /tmp/image.tar 
wait
echo "done"
sed -i -e "s/HOSTIP/$HOSTIP/g" /tmp/grub/grub.cfg 
cp -rf /tmp/grub /srv/install/boot/
/usr/bin/in.tftpd --listen --secure -l -s -vvv /srv/install/boot 
/usr/sbin/start_restserver.sh >> /tmp/restServer.log &
#cp -f /etc/dhcpd.conf /etc/dhcp/dhcpd.conf
/usr/bin/dhcpd -4  
/usr/bin/exportfs -a  
rpcbind  
/usr/sbin/rpc.statd  
/usr/sbin/rpc.nfsd  
rpc.mountd --foreground 
wait
