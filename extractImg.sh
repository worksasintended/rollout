#!/bin/bash
IMAGENAME=incubus/autoinstall_centos-cluster_node-image
CONTAINER_NAME="temp"
docker run -d --name $CONTAINER_NAME $IMAGENAME sleep 1000000
docker export $CONTAINER_NAME -o out.tar
docker kill $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

