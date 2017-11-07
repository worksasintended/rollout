#!/bin/bash
if [ "$2" -eq 1 ];then
        address='               filename "grub/i386-pc/core.0";'
elif [ "$2"  -eq 0 ];then 
        address='#               filename "grub/i386-pc/core.0";'
else
        address='funny thing, you did something wrong!'
fi

sed  "/$1/{n;s|.*|$address|}" /etc/dhcpd.conf > /etc/dhcpd.conf.new
cp -f /etc/dhcpd.conf.new /etc/dhcpd.conf


killall dhcpd
dhcpd 
