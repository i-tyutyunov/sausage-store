# /bin/bash
set -xe
export PSQL_USER="std-025-75"
sudo cp -rf sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service

cd /opt/sausage-store/bin
sudo curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.jar \
${NEXUS_REPO_URL}/repository/${NEXUS_REPO_BACKEND_NAME}/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar

sudo systemctl daemon-reload
sudo systemctl restart sausage-store-backend