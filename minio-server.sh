#!/bin/bash
apt-get -y update
apt-get -y install docker.io

mkdir -p /data
docker run --name minio -d -v $PWD/data:/data -p 9000:9000 -e MINIO_ACCESS_KEY=admin -e MINIO_SECRET_KEY=miniopassword minio/minio server /data
