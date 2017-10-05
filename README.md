# rollout
Cluster image rollout

Cluster rollout based on restserver/nfs. Everything running in docker. 
for startup a image must be provided that has nfs modules in kernel and does what ever it should do on the node. 
If its a rollout image make sure it provides a curl to the rest server at the end.
The dhcpd.conf must be created in the way this example shows. Esp the bootline has to be after the hardware address line!
