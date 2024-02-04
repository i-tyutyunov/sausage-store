# /bin/bash
set -xe
sudo mkdir -p /opt/sausage-store/bin/current-version
sudo rm -rf /opt/sausage-store/bin/current-version/*

cd /opt/sausage-store/bin/current-version
sudo curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store-${VERSION}.jar \
${NEXUS_REPO_URL}/repository/${NEXUS_REPO_BACKEND_NAME}/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar

sudo ln -sf /opt/sausage-store/bin/current-version/sausage-store-${VERSION}.jar /opt/sausage-store/bin/sausage-store.jar

sudo systemctl daemon-reload
sudo systemctl restart sausage-store-backend