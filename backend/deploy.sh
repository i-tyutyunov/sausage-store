# /bin/bash
set -xe
sudo mkdir -p /opt/sausage-store/bin/current-version
sudo rm -rf /opt/sausage-store/bin/current-version/*

cd /opt/sausage-store/bin/current-version
sudo curl -u std-025-75:7q2g4NSw -o sausage-store-${VERSION}.jar https://nexus.praktikum-services.tech/repository/std-025-75-backend/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar

sudo ln -sf /opt/sausage-store/bin/current-version/sausage-store-${VERSION}.jar /opt/sausage-store/bin/sausage-store.jar

sudo systemctl daemon-reload
sudo systemctl restart sausage-store-backend