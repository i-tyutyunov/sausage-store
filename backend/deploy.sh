#/bin/bash

NUM_INSTANCES = 1

echo "123"
echo $NUM_INSTANCES
echo "321"
exit
APP_NAME="sausage-store-backend"

echo "Determine the current version of the application (blue or green)"
CURRENT_VERSION=$(docker ps --filter "name=sausage-store-backend-" --format "{{.Names}}" | grep -oE "blue|green" |head -n1)
NEW_VERSION="green"
if [ $CURRENT_VERSION == $NEW_VERSION ]; then
    NEW_VERSION="blue"
fi

echo "Removing existing instances: $NEW_VERSION"
for instance in $(docker ps --filter "name=$APP_NAME-$NEW_VERSION-$instance" --format "{{.Names}}"); do
    docker rm -f $instance
done

echo "CURRENT_VERSION: $CURRENT_VERSION"
echo "NEW_VERSION: $NEW_VERSION"

docker login -u ${CI_REGISTRY_USER} -p${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker compose --env-file deploy.env up "backend-$NEW_VERSION" --scale "backend-$NEW_VERSION=$NUM_INSTANCES" -d --pull "always" --no-recreate

while true; do
    health_check_passed=true

    for instance in $(seq 1 $NUM_INSTANCES); do
        if ! docker ps -f "name=$APP_NAME-$NEW_VERSION-$instance" --format "{{.Status}}" | grep -q "healthy"; then
            health_check_passed=false
            break
        fi
    done

    if [ $health_check_passed ]; then
        echo "Health Check passed for all $NEW_VERSION instances."
        break
    fi

    echo "Health Check is still in progress..."
    sleep 5
done

echo "Deployment successful: $NEW_VERSION"

echo "Removing old instances: $CURRENT_VERSION"
for instance in $(docker ps --filter "name=$APP_NAME-$CURRENT_VERSION-$instance" --format "{{.Names}}"); do
    docker rm -f $instance
done