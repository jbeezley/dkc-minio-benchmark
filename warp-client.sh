#!/bin/bash

docker run --name warp-client -d -p 7761:7761 minio/warp client 0.0.0.0:7761
