#!/bin/bash
echo "unpacking image"
tar  -C /srv/install -xf /tmp/image.tar 
wait
echo "done"
sed -i -e "s/HOSTIP/$HOSTIP/g" /tmp/grub/grub.cfg 
cp -rf /tmp/grub /srv/install/boot/
/usr/bin/in.tftpd --listen --secure -l -s -vvv /srv/install/boot >> /tmp/tftpd.log &
/usr/sbin/start_restserver.sh >> /tmp/restServer.log &
#cp -f /etc/dhcpd.conf /etc/dhcp/dhcpd.conf
/usr/bin/dhcpd -4 >> /tmp/dhcp.log &
/usr/bin/exportfs -a >> /tmp/export.log &
rpcbind >> /tmp/rpcBind.log &
/usr/sbin/rpc.statd >> /tmp/rpcStatd.log &
/usr/sbin/rpc.nfsd  >> /tmp/rpcNfsd.log&
rpc.mountd --foreground 
wait
