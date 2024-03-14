#! /bin/bash
set -xe

sudo docker login -u ${CI_REGISTRY_USER} -p${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
sudo docker network create -d bridge sausage_network || true
sudo docker rm -f sausage-frontend || true
sudo docker run -d --name sausage-frontend \
     -v "/home/student/default.conf:/etc/nginx/conf.d/default.conf" \
     -p 8080:80 \
     --restart=always  \
     --network=sausage_network \
     "${CI_REGISTRY_IMAGE}/sausage-frontend:latest"