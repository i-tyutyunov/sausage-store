#! /bin/bash
set -xe

is_backend_running() {
    docker ps -q --filter "name=backend"
}

while ! is_backend_running; do
    echo "Backend is not running yet, waiting..."
    sleep 1
done

echo "Backend is running, starting frontend..."

sudo docker login -u ${CI_REGISTRY_USER} -p${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
sudo docker network create -d bridge sausage_network || true
sudo docker rm -f sausage-frontend || true
sudo docker run -d --name sausage-frontend \
     -v /home/student/example-02/frontend/default.conf:/etc/nginx/conf.d/default.conf \
     -p 9000:80 \
     --restart=always  \
     --network=sausage_network \
     "${CI_REGISTRY_IMAGE}"/sausage-frontend:latest