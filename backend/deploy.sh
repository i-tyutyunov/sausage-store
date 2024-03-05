# /bin/bash
set -xe

check_certificate_existence() {
    keytool -list -keystore /etc/ssl/certs/java/cacerts -alias yandex -storepass changeit >/dev/null 2>&1
    return $?
}

if ! check_certificate_existence; then
  wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/YandexInternalRootCA.crt
  sudo keytool -importcert \
               -file ~/YandexInternalRootCA.crt \
               -alias yandex \
               -cacerts \
               -storepass changeit \
               -noprompt
fi

sudo cp -rf sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service

cd /opt/sausage-store/bin
sudo curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.jar \
${NEXUS_REPO_URL}/repository/${NEXUS_REPO_BACKEND_NAME}/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar

sudo systemctl daemon-reload
sudo systemctl restart sausage-store-backend