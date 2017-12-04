docker run \
	--rm \
	--name "rollout" \
	--net host \
	-e "HOSTIP=10.10.0.1"  \
	-p 111:111 -p 111:111/udp \
	-p 69:69 -p 69:69/udp \
	-p 18080:18080 \
	-p 2049:2049 -p 2049:2049/udp \
	-v $(pwd)/out.tar:/tmp/image.tar \
	-v $(pwd)/dhcpd.conf:/etc/dhcpd.conf \
	--privileged \
	rollout


