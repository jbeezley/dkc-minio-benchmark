#!/bin/bash
sudo apt-get -y update
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get -y update
sudo apt-get install docker-ce docker-ce-cli containerd.io

mkdir -p /data
docker run --name minio -d -v $PWD/data:/data -p 9000:9000 -e MINIO_ACCESS_KEY=admin -e MINIO_SECRET_KEY=miniopassword minio/minio server /data
